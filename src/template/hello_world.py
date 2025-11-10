from time import sleep
from loguru import logger
from tqdm import tqdm


def add(a: int, b: int) -> int:
    return a + b


if __name__ == "__main__":
    logger.info("Starting Hello World")
    for i in tqdm(range(100), desc="Hello World", total=100):
        sleep(0.01)
    logger.success("Hello World Done!")
    