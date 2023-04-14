#!/bin/bash
set -x

main() {
    image_name="$(./util/build.sh "${1}" | awk '{print $2}' | awk '{print $1}' FS=':')"
    IMAGE_TAGS=(latest "$(date +%Y%m%d)" "$(git rev-parse HEAD)")
    IMAGE_REGISTRY="${IMAGE_REGISTRY:-ghcr.io/akdev1l/ostree-images}"

    for tag in ${IMAGE_TAGS}; do
        podman tag "${image_name}:latest" "${IMAGE_REGISTRY}/${image_name}:${tag}"
        podman push "${image_name}:latest" "${IMAGE_REGISTRY}/${image_name}:${tag}"
        echo "published: ${IMAGE_REGISTRY}/${image_name}:${tag}"
    done
}

main "$@"
