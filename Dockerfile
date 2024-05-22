FROM ruby:2.7.8

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y curl gnupg2

# Node.jsのリポジトリを追加してインストール（バージョン14）
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

# npmのバージョンを確認してアップグレード
RUN npm install -g npm@6.14.17  # Node.js 14に対応するnpmのバージョン

# Yarnのインストール
RUN npm install -g yarn

# その他の必要なパッケージのインストール
RUN apt-get install -y mariadb-client libmariadb-dev-compat libmariadb-dev libxml2-dev libxslt1-dev

# Ruby 2.7と互換性のあるBundlerのバージョンをインストール
RUN gem install bundler:2.1.4

# アプリケーションディレクトリの作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockをコピーし、Gemをインストール
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp
