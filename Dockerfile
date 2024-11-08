# syntax=docker/dockerfile:1
FROM julia:1.11.1

# # Install git
# RUN /bin/sh -c 'export DEBIAN_FRONTEND=noninteractive \
#     && apt-get update \
#     && apt-get install -y git \
#     && apt-get --purge autoremove -y \
#     && apt-get autoclean \
#     && rm -rf /var/lib/apt/lists/*'

# Docker is awful and doesn't allow conditionally setting environment variables in a decent
# way, so we have to keep an external script and source it every time we need it.
COPY julia_cpu_target.sh /julia_cpu_target.sh

RUN julia --color=yes -e 'using InteractiveUtils; versioninfo()'

# Instantiate Julia project
RUN . /julia_cpu_target.sh && julia --color=yes -e 'using Pkg; Pkg.add("Example")'
