# あなたと相性の良い都道府県アプリ

## 概要

「あなたと相性の良い都道府県アプリ」は、株式会社ゆめみが iOS エンジニアを希望する未経験者向けのコードチェック課題の一環として提供されています。このアプリは、ユーザーが名前、誕生日、血液型を入力することで、特定の API にアクセスし、都道府県に関する情報を取得して表示します。

## 使用技術

- SwiftUI

## API 仕様

- Base URL: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"
- End Point: "/my_fortune"
- HTTP Method: "POST"
- HTTP Request Headers:
  - Key: "API-Version", Value: "v1"
- HTTP Body:
  - "name": String - 占う人の名前
  - "birthday": YearMonthDay - 占う人の生年月日
  - "blood_type": String - 占う人の血液型
  - "today": YearMonthDay - 今日の日付
    - YearMonthDay 型の仕様:
      - "year": Int - 年
      - "month": Int - 月
      - "day": Int - 日
- Response Body:
  - "name": String - 都道府県の名前
  - "capital": String - 県庁所在地
  - "has_coast_line": Bool - 海岸線があるかどうか
  - "logo_url": String - ロゴの URL
  - "brief": String - 都道府県の概要
  - MonthDay 型の仕様:
    - "month": Int - 月
    - "day": Int - 日

## コード概要

### ContentView

- ユーザーが名前、誕生日、血液型を入力する画面を提供
- 入力情報を元に API にリクエストを送信

### DivinationApp

- API から受け取ったデータを表示する画面
- 画像データを非同期で取得して表示

