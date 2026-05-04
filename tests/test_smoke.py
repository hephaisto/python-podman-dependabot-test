import re
import sys
import subprocess

import pytest

from playwright.sync_api import Page, expect

@pytest.fixture(scope="function", autouse=True)
def run_server():
    with subprocess.Popen([sys.executable, "-u", "-m", "python_podman_dependabot_test.cmdline", "127.0.0.1"], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, env={"NICEGUI_SCREEN_TEST_PORT": "8080"}) as p:
        print("started server")
        for line in p.stdout:
            print(line)
            if "ready" in line:
                break
        yield
        p.terminate()
    print("stopped server")

def test_smoke(page: Page):
    page.goto("http://localhost:8080/")
    expect(page.get_by_role("main")).to_contain_text("python-podman-dependabot-test")

def test_smoke2(page: Page):
    page.goto("http://localhost:8080/")
    expect(page.get_by_role("main")).to_contain_text("nicegui")

