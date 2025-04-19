# AWS_Peering
테라폼으로 AWS VPC Peering 배포하기

# 🌐 VPC Multi-Region Peering with Terraform

이 리포지토리는 **AWS VPC 간 멀티 리전 피어링(Multi-Region Peering)** 구성을 자동화하는 Terraform 코드입니다. 서로 다른 AWS 리전에 존재하는 VPC 간 통신을 가능하게 하여 글로벌 네트워크 인프라를 쉽게 구성할 수 있도록 돕습니다.

---

## 📁 구성 요소

- ✅ 두 개 이상의 리전에 걸친 VPC 생성
- ✅ VPC Peering 연결 설정
- ✅ 라우팅 테이블 업데이트
- ✅ 피어링 허용 보안 그룹 설정

---

## 🛠️ 사용 방법

### 1. 사전 준비

- AWS CLI가 설치되어 있어야 합니다.
- Terraform이 설치되어 있어야 합니다.
- 기본적인 AWS IAM 권한이 부여되어 있어야 합니다 (VPC, Peering, Route Table, Security Group 관련 권한 등).

### 2. 설정 파일 수정

`terraform.tfvars` 혹은 `variables.tf` 파일에 아래와 같은 항목들을 입력합니다:

```hcl
region_1 = "ap-northeast-2"
region_2 = "us-west-1"

vpc_cidr_region_1 = "10.0.0.0/16"
vpc_cidr_region_2 = "10.1.0.0/16"
