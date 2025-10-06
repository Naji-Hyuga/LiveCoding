import sys
import shutil
import pytest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

@pytest.fixture(autouse=True)
def driver():
    options = Options()
    options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--window-size=1920,1080")

    if sys.platform.startswith("linux"):
        options.binary_location = shutil.which("chromium") or \
                                  shutil.which("chromium-browser") or \
                                  "/usr/bin/chromium"
        service = Service(shutil.which("chromedriver") or "/usr/bin/chromedriver")
        drv = webdriver.Chrome(service=service, options=options)
    else:
        drv = webdriver.Chrome(options=options)
    try:
        yield drv
    finally:
        drv.quit()