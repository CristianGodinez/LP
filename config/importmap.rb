# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "rails-ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js"
pin "chartkick", to: "https://cdn.jsdelivr.net/npm/chartkick@4.1.0/dist/chartkick.min.js"
pin "Chart.bundle", to: "https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"
