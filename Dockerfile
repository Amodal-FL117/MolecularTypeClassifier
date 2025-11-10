FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

WORKDIR /src

ENV PYTHONUNBUFFERED=1

# Install curl for downloading pixi and uv
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install pixi
RUN curl -fsSL https://pixi.sh/install.sh | bash
ENV PATH="/root/.pixi/bin:${PATH}"

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy environment files and source code
COPY pyproject.toml pixi.lock ./
COPY src/ ./src/

# Install dependencies using pixi (this will use the exact locked versions)
# This will also install the local package since it's in pypi-dependencies
RUN pixi install --locked

# Use pixi run to execute the entrypoint within the pixi environment
ENTRYPOINT ["pixi", "run", "python", "src/template/hello_world.py"]

