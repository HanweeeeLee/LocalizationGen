# LocalizationGen
## .csv 파일을 Localization 파일로 변환해주는 macOS 어플리케이션입니다.

## 개발 이유
 - 개발자가 아닌 다른 사람이 정하는 문구를 개발자가 지속적으로 수정해주어야하는 불편함 개선

## 지원 플랫폼
 - iOS
 - macOS
 - watchOS
 - tvOS
 
### 지속적으로 타 플랫폼을 지원할 계획입니다.

## How to Use
### XCode 기준
 - 앱을 적당한곳에 넣고 XCode에 스크립트를 추가해주세요.
 
 ```
 [앱 경로] inputPath=[csv파일 경로] outputPath=[Localization파일이 쓰여질 경로] fileName=[파일 이름] localColumnKeys=[Localization 키워드] keyColumnKey=[csv에 기입되어있는 Localization Key의 컬럼 키워드]
 ```
 
 #### ex)
```
${SRCROOT}/LocalizationGen inputPath="/Users/master/Downloads/test.csv" outputPath=${TARGETNAME}/Localization  fileName="myLocalization.string" localColumnKeys="ko&en" keyColumnKey="localize key"
```

## 제약사항
> .csv파일의 1행은 localColumnKeys, keyColumnKey등을 구분하기위해 사용되는 행입니다. 
> 추후 해당 행을 지정할 수 있도록 수정예정입니다. 

## param
## 앱에는 다음과 같은 파라미터를 지원합니다.
### required
 - inputPath : .csv파일의 경로
 - outputPath : 실행 결과로 나올 Localization 파일의 경로
 - fileName : Localization 파일의 이름
 - localColumnKeys : 지원할 다국어의 키, 여러개일 경우 &로 구분 ex) ko, en
 - keyColumnKey : Localization의 키가 될 컬럼
### optional
 - platform : 플랫폼을 지정합니다.
 #### 플랫폼 별 키워드
  - iOS, macOS, watchOS, tvOS  -> Apple
  - Android -> Android
  
## 구글 스프레드시트와 연동
### 만약 구글 스프레드시트로 다국어를 정리하고 있다면 구글 스프레드시트에서 IDE로 바로 다국어 파일을 만들 수 있습니다!
ex)  
샘플 주소: https://docs.google.com/spreadsheets/d/1jujeVA4qZVKnL6Cv3-_Ik_LlIp7YnAJ3Q_vmHXcyknw/edit?usp=sharing  
샘플 쉘 스크립트
```shell
curl -L "https://docs.google.com/feeds/download/spreadsheets/Export?key=1jujeVA4qZVKnL6Cv3-_Ik_LlIp7YnAJ3Q_vmHXcyknw&exportFormat=csv&gid=775030050" -o "localization.csv"
./LocalizationGen outputPath="../Projects/Resources/Localization" keyColumnKey="key" platform="Apple" fileName="Localizable.strings" localColumnKeys="ko&en" inputPath="./localization.csv"
```

















