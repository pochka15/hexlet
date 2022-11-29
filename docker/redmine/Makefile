# Section tutorial steps

step5:
	echo "Step 5 - Session store secret generation" && bundle exec rake generate_secret_token

step6:
	echo "Step 6 - Database schema objects creation" && RAILS_ENV=production bundle exec rake db:migrate

step7:
	echo "Step 7 - Database default data set" && RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data

step9:
	echo "Step 9 - Test the installation" && bundle exec rails server -u webrick -e production

# Section App

start: step5 step6 step7 step9

# Section docker compose

compose:
	docker-compose up -d

compose-production:
	docker-compose --file docker-compose.yml run production

compose-build:
	docker-compose build

compose-logs:
	docker-compose logs -f

compose-down:
	docker-compose down || true

compose-clear:
	docker-compose down -v --remove-orphans || true

compose-stop:
	docker-compose stop || true

compose-restart:
	docker-compose restart

compose-setup: compose-down compose-build app-setup

compose-ci-build:
	docker build -f Dockerfile.production -t hexletbasics/services-app .
	docker build -f services/web-nginx/Dockerfile -t hexletbasics/services-web .
	docker-compose -f docker-compose.yml build

compose-ci: compose-ci-build
	docker-compose --file docker-compose.yml up --abort-on-container-exit