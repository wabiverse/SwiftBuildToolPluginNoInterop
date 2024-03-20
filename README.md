<!-- markdownlint-configure-file {
  "MD013": {
    "code_blocks": false,
    "tables": false
  },
  "MD033": false,
  "MD041": false
} -->

<div align="center">

<h1 align="center">
    <a href="#gh-light-mode-only">
      <img width="150" src="swift_logo_light.svg">
    </a>
    <a href="#gh-dark-mode-only">
      <img width="150" src="swift_logo_dark.svg">
    </a>
</h1>

<p align="center">
  <i align="center">Demonstrates a swiftpm <b>BuildToolPlugin</b> limitation when<br/> attempting to <b>generate headers</b> for use with <b>cxx interop</b>.</i>
</p>

</div>

<h4 align="center">
  <a href="https://github.com/wabiverse/SwiftBuildToolPluginNoInterop/actions/workflows/swift-ubuntu.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/wabiverse/SwiftBuildToolPluginNoInterop/swift-ubuntu.yml?style=flat-square&label=ubuntu%20&labelColor=E95420&logoColor=FFFFFF&logo=ubuntu">
  </a>
  <a href="https://github.com/wabiverse/SwiftBuildToolPluginNoInterop/actions/workflows/swift-macos.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/wabiverse/SwiftBuildToolPluginNoInterop/swift-macos.yml?style=flat-square&label=macOS&labelColor=000000&logo=apple">
  </a>
  <br>
  <a href="https://wabi.foundation">
    <img src="https://img.shields.io/badge/wabi_foundation-black?style=flat-square&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MDAgNTAwIj4KICA8ZGVmcz4KICAgIDxzdHlsZT4KICAgICAgLmNscy0xIHsKICAgICAgICBmaWxsOiAjNDM0MzQzOwogICAgICB9CgogICAgICAuY2xzLTEsIC5jbHMtMiB7CiAgICAgICAgc3Ryb2tlLXdpZHRoOiAwcHg7CiAgICAgIH0KCiAgICAgIC5jbHMtMiB7CiAgICAgICAgZmlsbDogI2ZmZjsKICAgICAgfQogICAgPC9zdHlsZT4KICA8L2RlZnM+CiAgPHBhdGggY2xhc3M9ImNscy0yIiBkPSJNMTMyLjQyLDMzOS42NXMtMzQuOS0yOC40OC00NS41Ny05OC42MmMtMy4xMy0yNy4yNS4xMS01My42NywxMC4xNS03OS4yMiwxMS40OS0yOS4yNSwyOS44OC01My4xOCw1NC45OS03Mi4wMyw0Ljk5LTMuNzQsMTAuNDUtNi44OCwxNC42LTExLjc1LDYuMDEtNy4wNiw3LjkxLTE1LjE0LDYuNzctMjQuMTUtLjg3LTYuNzUtMy4zNC0xMy01LjkzLTE5LjItMS42LTMuODUtMy4zNy03LjY2LTMuODktMTEuODgtLjk5LTcuODgsMy4yOS0xNC43NiwxMC43Mi0xNy42NSw3Ljg0LTMuMDcsMTUuODMtMi45NywyMy45Mi0xLjY1LDEyLjYsMi4wOCwyNC43Miw1LjkzLDM2LjY2LDEwLjM3LDIxLjg3LDguMTMsNDIuNjQsMTguNSw2Mi40MiwzMC44NiwyMi45OSwxNC4zNSw0NC4wNiwzMS4wOCw2Mi41Niw1MC45NiwxMy4zNywxNC4zOCwyNS4wOCwyOS45NiwzNC4zOCw0Ny4yNSwxOC4xMSwzMy42NywyNC4wMyw2OS40MiwxNy41OCwxMDcuMTctMi4yNSwxMy4yLTYuMTgsMjUuNzQtMTIuOTgsMzcuMzctMTIuMjMsMjAuODgtMzAuNDYsMzEuMTctNTQuNTUsMzEuNS0xMy4xNC4xNy0yNS41MS0zLjA0LTM3LjQ4LTguMDktMTEuMy00Ljc1LTIyLjA2LTEwLjQ2LTMyLjU3LTE2LjY2LTExLjY5LTYuODktOTguMzQtNjkuNzgtMTIwLjM0LTc0LjYxLTE3Ljk0LDMuMTYtMzMuNTYsNy45Ni00MS4xMSwyNC43LTM0LjU1LDMzLjg2LDE5LjcyLDk1LjM1LDE5LjcyLDk1LjM1aC0uMDNaTTMxMS42NSwyNTYuNjhjLjAzLTguMi05Ljc3LTE2LjE5LTE4LjE5LTE0Ljg0LTYuNTYsMS4wNS05Ljg1LDYuNjctNy41OCwxMi45MywyLjI3LDYuMjksOC43OCwxMC45NywxNS40NSwxMS4wOSw1LjkyLjEzLDEwLjI5LTMuNzksMTAuMzItOS4ydi4wMloiLz4KICA8cGF0aCBjbGFzcz0iY2xzLTIiIGQ9Ik0yOTguNCwzMzMuODZjMi43MS0xLjQ4LTczLjksODYuMTgtMTY2LjIsNS45LTIyLjk2LTE5Ljk3LTY3LjU2LTEyMC42Nyw1LjI0LTEyMi43MSw0Ni4yNy0xLjI5LDExOC4xMyw2NC42OCwxMTguMTMsNjQuNjgtMjguOTItMTkuNTQtODcuMDctNTkuMjktMTIyLjE1LTI3Ljk0LTQ3LjcyLDQyLjY2LDI0LjM2LDE1Ni4zNSwxNjQuOTcsODAuMDdoMFoiLz4KICA8cGF0aCBjbGFzcz0iY2xzLTIiIGQ9Ik0yMzIuNzEsMzU3LjljMTAuNy0zLjA3LDIwLjYzLTguMDQsMzAuODEtMTIuMzcsMTAuNy00LjU1LDIxLjQzLTkuMDMsMzIuOS0xMS4zOCw3LjExLTEuNDUsMTQuODgtMS40MiwxOS44Ny4xMS01LjYzLDguMTUtMTAuMjcsMTYuODItMTUuNTUsMjUuMTMtMi4xNCwzLjM4LTQuNTUsNi42MS03LjMsOS41Mi0xMS45MywxMi41Ny0yNi40NywxNy44My00Mi43NywxOC4wNi00LjE0LjA2LTguMjksMC0xMy4yLDAsNy4yOSwxLjUzLDEzLjc1LDMuMTMsMjAuMDYsNS40OSwxNS45MSw1Ljk2LDI1LjI3LDE3LjU2LDI5LjExLDMzLjc1LDQuMTksMTcuNjcsNi44NCwzNS42OSwxMS40NCw1My4yOSwxLjQyLDUuNDQsMi42NiwxMC45NSw0LjYxLDE2LjI0LjQ3LDEuMjYuNTIsMS44MS0xLjE2LDEuNTktMTcuNTktMi40MS0zNC42LTYuNjEtNTAuMTUtMTUuNTYtMTMuOTItOC4wMi0yNC43NS0xOS4xNi0zMy4yOC0zMi43LTcuOTYtMTIuNjUtMTMuNTgtMjYuNDctMTkuNy00MC4wMy0zLjIxLTcuMTEtNS4zMi0xMi45LTkuNDYtMTkuMTYtNC41My02LjgzLTEwLjU5LTEyLjUxLTE3LjUtMTYuOTMtMjguMzctMTguMTctNDQuNjUtMzguODgtNDUuMDgtMzkuMzQsMCwwLDI5LjU4LDM1LjczLDg0LjksMzAuMyw3LjMtMS40NSwxNC41NS0zLjA0LDIxLjQxLTYuMDFsLjAyLS4wMloiLz4KICA8cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik0zMTEuNjMsMjU2LjY4Yy0uMDIsNS40MS00LjQxLDkuMzEtMTAuMzIsOS4yLTYuNjctLjE0LTEzLjE5LTQuODEtMTUuNDUtMTEuMDktMi4yNy02LjI4LDEuMDItMTEuODgsNy41OC0xMi45Myw4LjQyLTEuMzUsMTguMjIsNi42NCwxOC4xOSwxNC44NHYtLjAyWiIvPgo8L3N2Zz4=" alt="wabi foundation" style="height: 20px;">
  </a>

  <h1 align="center">

  [**SwiftPM** #NA](#)

  </h1>
</h4>
