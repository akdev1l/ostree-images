#!/bin/bash
set -x


main() {
    image_name="$1"
    image_builddir="$PWD/images/${image_name}"

    if [ ! -d "images/${image_name}" ]; then
        printf 'could not find image "%s"\n"' "${image_name}"
        return 1
    fi


    image_id="$(podman build --format oci "${image_builddir}" | tail -1)"
    image_tag="${image_name}:latest"

    podman tag "${image_id}" "localhost/${image_tag}"

    printf 'created: %s\n' "${image_tag}"
}

main "$@"
