FROM ubuntu:22.04

# 非対話モード設定（tzdata等の対話を防ぐ）
ENV DEBIAN_FRONTEND=noninteractive

# 基本的な軽量化セットアップ
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        tini \
    && rm -rf /var/lib/apt/lists/* \
    # ロケールと不要ファイル削除で軽量化
    && rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/locale/* \
    && rm -rf /var/cache/*

# tini を init として設定（PID1問題対策）
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/bin/bash"]
