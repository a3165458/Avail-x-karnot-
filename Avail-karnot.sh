#!/bin/bash

# 第1部分：更新和升级包
echo "正在更新和升级包..."
sudo apt update && sudo apt upgrade -y

# 第2部分：安装Rust
echo "正在安装Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# 验证Rust安装
echo "验证Rust安装..."
rustc --version

# 第3部分：安装Git
echo "正在安装Git..."
sudo apt install git -y

# 第4部分：安装Docker及必要的包
echo "正在安装Docker及必要的包..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce -y

# 启动并启用Docker服务
echo "启动并启用Docker服务..."
sudo systemctl start docker
sudo systemctl enable docker

# 第5部分：安装额外的依赖项
echo "更新包并安装额外的依赖项..."
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install build-essential -y
sudo apt install pkg-config -y
sudo apt install libssl-dev -y
sudo apt install clang -y
sudo apt install protobuf-compiler -y
sudo apt install screen -y

# 第6部分：安装和配置Madara-CLI
echo "克隆Madara-CLI仓库并进行设置..."
git clone https://github.com/karnotxyz/madara-cli
cd madara-cli

# 构建Madara-CLI
echo "构建Madara-CLI..."
cargo build --release

# 初始化设置
echo "初始化Madara-CLI设置..."
./target/release/madara init

echo "安装和配置成功完成。"
