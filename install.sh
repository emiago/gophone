#!/bin/sh
set -eu

repo="emiago/gophone"
binary="gophone"
install_dir="${GOPHONE_INSTALL_DIR:-${INSTALL_DIR:-/usr/local/bin}}"
version="${GOPHONE_VERSION:-latest}"

fail() {
	echo "gophone install: $*" >&2
	exit 1
}

need_cmd() {
	command -v "$1" >/dev/null 2>&1 || fail "required command not found: $1"
}

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

run_install() {
	if [ "$need_sudo" -eq 1 ]; then
		sudo "$@"
	else
		"$@"
	fi
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

need_sudo=0
if [ -d "$install_dir" ]; then
	if [ ! -w "$install_dir" ]; then
		need_sudo=1
	fi
else
	parent_dir="$(dirname "$install_dir")"
	if [ ! -w "$parent_dir" ]; then
		need_sudo=1
	fi
fi

if [ "$need_sudo" -eq 1 ]; then
	need_cmd sudo
fi

run_install mkdir -p "$install_dir"
run_install install -m 0755 "$target" "${install_dir}/${binary}"

echo "Installed ${binary} to ${install_dir}/${binary}"
echo "Run '${binary} -h' to get started."
