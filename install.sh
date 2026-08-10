#!/bin/sh
set -eu

repo="emiago/gophone"
binary="gophone"
version="${GOPHONE_VERSION:-latest}"

fail() {
	echo "gophone install: $*" >&2
	exit 1
}

need_cmd() {
	command -v "$1" >/dev/null 2>&1 || fail "required command not found: $1"
}

if [ -n "${GOPHONE_INSTALL_DIR:-}" ]; then
	install_dir="$GOPHONE_INSTALL_DIR"
elif [ -n "${INSTALL_DIR:-}" ]; then
	install_dir="$INSTALL_DIR"
else
	[ -n "${HOME:-}" ] || fail "HOME is not set; set GOPHONE_INSTALL_DIR to choose an installation directory"
	install_dir="${HOME}/.local/bin"
fi

detect_os() {
	case "$(uname -s)" in
		Linux)
			echo "linux"
			;;
		*)
			fail "unsupported OS: $(uname -s). Only Linux is supported by this installer for now."
			;;
	esac
}

detect_arch() {
	case "$(uname -m)" in
		x86_64|amd64)
			echo "amd64"
			;;
		aarch64|arm64)
			echo "arm64"
			;;
		*)
			fail "unsupported architecture: $(uname -m). Supported architectures: amd64, arm64."
			;;
	esac
}

download() {
	url="$1"
	output="$2"

	if command -v curl >/dev/null 2>&1; then
		curl -fsSL "$url" -o "$output"
		return
	fi

	if command -v wget >/dev/null 2>&1; then
		wget -q "$url" -O "$output"
		return
	fi

	fail "curl or wget is required to download gophone"
}

os="$(detect_os)"
arch="$(detect_arch)"
asset="${binary}-${os}-${arch}"

case "$version" in
	latest)
		url="https://github.com/${repo}/releases/latest/download/${asset}"
		;;
	v*)
		url="https://github.com/${repo}/releases/download/${version}/${asset}"
		;;
	*)
		url="https://github.com/${repo}/releases/download/v${version}/${asset}"
		;;
esac

need_cmd uname
need_cmd chmod
need_cmd install
need_cmd mktemp

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT INT TERM

target="${tmp_dir}/${binary}"

echo "Downloading ${asset} from ${repo}..."
download "$url" "$target"
chmod +x "$target"

mkdir -p "$install_dir" || fail "cannot create installation directory: $install_dir"
[ -w "$install_dir" ] || fail "installation directory is not writable: $install_dir"
install -m 0755 "$target" "${install_dir}/${binary}" || fail "could not install ${binary} to ${install_dir}"

echo "Installed ${binary} to ${install_dir}/${binary}"
case ":${PATH:-}:" in
	*":${install_dir}:"*)
		echo "Run '${binary} -h' to get started."
		;;
	*)
		echo "Add ${install_dir} to your PATH, then run '${binary} -h':"
		echo "  export PATH=\"${install_dir}:\$PATH\""
		;;
esac
