FROM crystallang/crystal:1.7.2

WORKDIR /app

COPY shard.yml ./

RUN shards install

COPY . .

RUN crystal build --release examples/simple_mining_generator.cr

ENTRYPOINT ["./simple_mining_generator"]
