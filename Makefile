build-web:
	docker build -t hiogawa/rails:app .

run-db:
	docker run --name db -e MYSQL_ROOT_PASSWORD=dontcare -d mysql

run-web:
	docker run --name web --link db:db -p 80:80          -d hiogawa/rails:app

# after running web
# you can migrate database by running command interactively like,
# $ docker exec -it web bash
# $ $ eval "$(rbenv init -)"
# $ $ rake db:create && rake db:migrate

clean-db:
	docker stop db  && docker rm db

clean-web:
	docker stop web && docker rm web
