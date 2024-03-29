# LocalizationGen
## MacOS application that converts .csv files into localization files.

## Reasons for development
- Improves the inconvenience of developers having to constantly modify phrases that are determined by people other than developers.

## Supported Platforms
- iOS
- macOS
- watchOS
- tvOS
- Android

### We plan to continue to support other platforms.

## How to Use
### Based on XCode
- Please put the app in the right place and add the script to XCode.

```
[App Path] inputPath=[csvFile Path] outputPath=[Path where Localization file will be written] fileName=[File Name] localColumnKeys=[Localization Key] keyColumnKey=[Column Key] written in csv
```

#### ex)
```
${SRCROOT}/LocalizationGen inputPath="/Users/master/Downloads/test.csv" outputPath=${TARGETNAME}/Localization fileName="myLocalization.string" localColumnKeys="ko&en" keyColumnKey="localize key"
```

## Restrictions
The row 1 in the > .csv file is used to distinguish between localColumnKey, keyColumnKey, and so on.
> It will be revised so that the row can be designated later.

## param
## The app supports the following parameters:
### required
- inputPath : Path to the .csv file
- outputPath : the path to the localization file that will result in execution
- fileName : Name of the Localization file
- localColumnKeys : keys of multiple languages to support, separated by & if multiple, ex) ko, en
- keyColumnKey : Column to be the key for Localization
### optional
- platform : Specifies the platform.
#### Keywords by platform
- iOS, macOS, watchOS, tvOS -> Apple
- Android -> Android

## Interworking with Google Spreadsheets
### If you're organizing multilingual files with Google spreadsheets, you can create multilingual files directly from Google spreadsheets to IDE!
ex)
Sample Sheets: https://docs.google.com/spreadsheets/d/1jujeVA4qZVKnL6Cv3-_Ik_LlIp7YnAJ3Q_vmHXcyknw/edit?usp=sharing  
Sample Shell Script
```shell
curl -L "https://docs.google.com/feeds/download/spreadsheets/Export?key=1jujeVA4qZVKnL6Cv3-_Ik_LlIp7YnAJ3Q_vmHXcyknw&exportFormat=csv&gid=775030050" -o "localization.csv"
./LocalizationGen outputPath="../Projects/Resources/Localization" keyColumnKey="key" platform="Apple" fileName="Localizable.strings" localColumnKeys="ko&en" inputPath="./localization.csv"
```
