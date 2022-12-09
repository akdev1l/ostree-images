#!/bin/bash
set -x

main() {
    image_name="$(./util/build.sh "${1}" | awk '{print $2}' | awk '{print $1}' FS=':')"

    for tag in ${IMAGE_TAGS}; do
        podman tag "${image_name}" "${IMAGE_REGISTRY}/${image_name}:${tag}"
        podman push "${image_name}" "${IMAGE_REGISTRY}/${image_name}:${tag}"
        echo "published: ${IMAGE_REGISTRY}/${image_name}:${tag}"
    done

}

main "$@"
