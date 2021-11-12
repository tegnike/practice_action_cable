# quickstart
個人用Railsクイックスタートリポジトリ。
詳細な手順はほぼパクった[Qiita](https://qiita.com/kodai_0122/items/795438d738386c2c1966#1-4-gemfilelock-%E4%BD%9C%E6%88%90)を参考にする。

## rails new

```
# 適宜変更
$ docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle
```

## bundle install

```
$ docker-compose build
```

## webpacker install

```
$ docker-compose run web bundle exec rails webpacker:install
```

## Yay! You're on Rails!

`database.yml` を `config` 配下に移動

```
$ docker-compose up -d
$ docker-compose exec web /bin/bash

# コンテナ内
% rails db:create
```