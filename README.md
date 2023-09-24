# VotesApp

## チャート
基本的にはMVVM構造を採用、InteractorはViewModel部分に相当する（名称検討中）。
原則としてSOLIDを意識した構造とする、現時点ではレイヤーでモジュールを分割しているが（developブランチ参照）、将来的には機能ごとにパッケージを切り分け、メインでモジュールを結合して、
一つの動作するアプリとしたい。

![Votes](https://github.com/Jinno-Shigeki/VotesApp/assets/63356965/e802841c-017e-4812-b072-19b2b5246ab0)

非同期処理にはasync/awaitを採用。
