FROM node:22

# 1. 필수 도구 설치
RUN apt-get update && apt-get install -y curl bash unzip git && rm -rf /var/lib/apt/lists/*

# 2. 공식 설치 스크립트 실행
RUN curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard


# 3. 환경 변수 설정
ENV PATH="/root/.openclaw/bin:${PATH}"

# 4. 초기 설정 생성 후 템플릿 덮어쓰기 + 백업
RUN openclaw doctor --fix
COPY openclaw.json /root/.openclaw/openclaw.json
RUN cp -a /root/.openclaw /root/.openclaw-defaults

# 5. 엔트리포인트 복사
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 6. 실행
EXPOSE 18789
CMD ["/entrypoint.sh"]