#!/bin/bash

# 환경 변수 설정
export WORK="/root/hanafuda"
export NVM_DIR="$HOME/.nvm"

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # 색상 초기화

echo -e "${GREEN}Hana 봇을 설치합니다.${NC}"
echo -e "${GREEN}스크립트작성자: https://t.me/kjkresearch${NC}"

echo -e "${GREEN}설치 옵션을 선택하세요:${NC}"
echo -e "${YELLOW}1. Hana 봇 새로 설치${NC}"
echo -e "${YELLOW}2. 재실행하기${NC}"
read -p "선택: " choice

case $choice in
  1)
    echo -e "${GREEN}Humanity 봇을 새로 설치합니다.${NC}"

    # 사전 필수 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y git

    echo -e "${YELLOW}작업 공간 준비 중...${NC}"
    if [ -d "$WORK" ]; then
        echo -e "${YELLOW}기존 작업 공간 삭제 중...${NC}"
        rm -rf "$WORK"
    fi

    # GitHub에서 코드 복사
    echo -e "${YELLOW}GitHub에서 코드 복사 중...${NC}"
    git clone https://github.com/KangJKJK/hanafuda.git
    cd "$WORK"

    # 파이썬 및 필요한 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y python3 python3-pip
    pip install -r requirements.txt

    # 사용자에게 프록시 사용 여부를 물어봅니다.
    read -p "개인키를 입력하세요. 여러 계정일 경우 쉼표로 구분하세요.: " private_keys

    # 개인키를 배열로 변환
    IFS=',' read -r -a keys_array <<< "$private_keys"

    # private_keys.txt 파일 생성 및 초기화
    {     
        for key in "${keys_array[@]}"; do
            echo "$key"
        done
    } > "$WORK/pvkey.txt"

    echo -e "${GREEN}개인키 정보가 pvkey.txt파일에 저장되었습니다.${NC}"

    echo -e "${GREEN}해당 사이트에 가입을 진행해주세요: https://hanafuda.hana.network/dashboard${NC}"
    read -p "가입을 하셨다면 엔터를 눌러주세요.: "
    echo -e "${GREEN}해당 사이트에서 Deposit을 1회 진행하세요: https://hanafuda.hana.network/deposit${NC}"
    read -p "Deposit을 하셨다면 엔터를 눌러주세요.: "
    echo -e "${YELLOW}이 봇은 자동 디파짓 기능만 있습니다. 사용자는 대쉬보드에서 Gorw 및 Drawhanafuda를 수동으로 진행하셔서 에어드랍 작업을 진행하셔야합니다.${NC}"
    read -p "확인하셨으면 엔터를 눌러주세요..: "

    # 봇 구동
    python3 bot.py
    ;;
    
  2)
    echo -e "${GREEN}Humanity 봇을 재실행합니다.${NC}"
    
    cd "$WORK"

    # 파이썬 및 필요한 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y python3 python3-pip
    pip install -r requirements.txt

    # 봇 구동
    python3 bot.py
    ;;

  *)
    echo -e "${RED}잘못된 선택입니다. 다시 시도하세요.${NC}"
    ;;
esac
