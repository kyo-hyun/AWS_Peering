# AWS_Peering
테라폼으로 AWS Multi Region VPC Peering 배포하기

# 🌐 VPC Multi-Region Peering with Terraform

이 레포지토리는 **AWS VPC 간 멀티 리전 피어링(Multi-Region Peering)** 구성을 위한 테라폼 코드입니다.
아직 수정이 많이 필요한 단계로 간단한 테스트용도로 사용가능합니다.

---

## 📁 구성 요소

- ✅ 서울 리전 및 도쿄 리전에 VPC 생성
- ✅ VPC Peering 연결 설정
- ✅ 라우팅 테이블 업데이트

---

## 🛠️ 사용 방법

- 현재는 서울, 도쿄 리전 뿐이므로 다른 리전 사용시 provider 수정이 필요합니다.
- 서울리전이 requester가 되며 도쿄 리전은 accepter가 됩니다. 
- peering을 제외한 나머지 리소스(vpc,routetable)는 리전 별로 module이 분리되어 있습니다.
- 만약 vpc 추가가 필요한 경우 vpc.tf locals에 vpc를 추가하시면 됩니다.( 나머지 리소스도 마찬가지 입니다.)