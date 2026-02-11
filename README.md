# OpenClaw Docker (찍먹용)

이 저장소는 [OpenClaw](https://openclaw.ai/)를 Docker를 통해 쉽고 빠르게 체험해볼 수 있도록 구성된 프로젝트입니다. 복잡한 설정 없이 환경 변수만 입력하면 바로 실행할 수 있도록 최적화되어 있습니다.

## 🚀 주요 특징

- **간편한 실행**: Docker Compose를 사용하여 명령어 한 줄로 실행 가능합니다.
- **자동 페어링**: 텔레그램 채널 사용 시 페어링 코드를 자동으로 승인하도록 설정되어 있어 편리합니다.
- **멀티 아키텍처 지원**: `amd64` 및 `arm64`(Apple Silicon 포함)를 모두 지원합니다.
- **영속성 지원**: 로컬 디렉토리와 볼륨을 연결하여 설정을 유지합니다.

## 🛠 준비 사항

실행을 위해 다음 API 키들이 필요합니다:

1. **Google Gemini API Key**: [Google AI Studio](https://aistudio.google.com/)에서 발급 가능합니다.
2. **Telegram Bot Token**: [@BotFather](https://t.me/botfather)를 통해 봇을 생성하고 토큰을 받으세요.
3. **Telegram User ID**: 본인의 텔레그램 ID가 필요합니다. [@userinfobot](https://t.me/userinfobot) 등을 통해 확인할 수 있습니다.
4. **Brave API Key (선택)**: 웹 검색 기능을 사용하려면 [Brave Search API](https://brave.com/search/api/) 키가 필요합니다.

## 🏃‍♂️ 시작하기

### 1. 저장소 클론 및 이동

```bash
git clone https://github.com/your-repo/Openclaw-docker.git
cd Openclaw-docker
```

### 2. 설정 수정 (`docker-compose.yml`)

`docker-compose.yml` 파일의 `environment` 섹션을 자신의 정보로 수정합니다:

```yaml
environment:
  - OPENCLAW_GATEWAY_TOKEN=your_secure_token  # 게이트웨이 접속용 토큰 (자유롭게 지정)
  - GEMINI_API_KEY=your_gemini_api_key        # 구글 API 키
  - TELEGRAM_BOT_TOKEN=your_bot_token        # 텔레그램 봇 토큰
  - TELEGRAM_ALLOWED_USERS=12345678,98765432  # 봇 사용을 허용할 텔레그램 ID (쉼표로 구분)
  - BRAVE_API_KEY=your_brave_api_key          # 브레이브 API 키 (선택 사항)
```

### 3. 컨테이너 실행

```bash
docker compose up -d
```

### 4. 텔레그램 봇과 대화 시작

1. 생성한 텔레그램 봇에게 말을 겁니다.
2. 봇이 페어링 코드를 보내면, 컨테이너 내의 자동 승인 스크립트가 이를 감지하여 자동으로 승인합니다 (약 5~10초 소요).
3. 승인이 완료되면 바로 OpenClaw와 대화를 시작할 수 있습니다!

## 📂 파일 구조

- [dockerfile](file:///Users/dongyopark/Downloads/Openclaw-docker/dockerfile): OpenClaw 설치 및 환경 구성 정의
- [docker-compose.yml](file:///Users/dongyopark/Downloads/Openclaw-docker/docker-compose.yml): 서비스 실행 및 환경 변수 설정
- [openclaw.json](file:///Users/dongyopark/Downloads/Openclaw-docker/openclaw.json): OpenClaw 상세 설정 템플릿
- [entrypoint.sh](file:///Users/dongyopark/Downloads/Openclaw-docker/entrypoint.sh): 자동 페어링 로직이 포함된 실행 스크립트
- [build.sh](file:///Users/dongyopark/Downloads/Openclaw-docker/build.sh): 이미지 빌드 스크립트 (개발자용)

## 📝 참고 사항

- **데이터 저장**: `./openclaw` 디렉토리에 OpenClaw의 모든 설정과 데이터가 저장됩니다.
- **모델 설정**: 기본적으로 `gemini-2.5-flash-lite` 모델을 사용하도록 설정되어 있습니다. 변경이 필요한 경우 `openclaw.json`을 수정하세요.
- **보안**: `OPENCLAW_GATEWAY_TOKEN`은 외부에서 게이트웨이에 접근할 때 사용되는 비밀번호 역할을 하므로 안전한 문자열로 변경하는 것을 권장합니다.

## 🛠 직접 빌드하기 (선택 사항)

자신만의 이미지를 빌드하려면 다음 스크립트를 사용하세요:

```bash
chmod +x build.sh
./build.sh
```
