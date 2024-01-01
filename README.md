# README

Disbursement calculation and build project for Sequra.

* Ruby version
  * 3.1.2

* System dependencies
  * Rails version
    * 7.1.2
  * Check dependency details from Gemfile.

* Configuration
  * Rails project initalized as API only so could also be used to fetched data from remote.

* Database creation
  * ```$rake db:create```
  
* Database initialization
  * ```$rake db:migrate```

* How to run the test suite
  * Rspec used for unit testing.
    * ```$rspec spec```

* Services (job queues, cache servers, search engines, etc.)
  * Sidekiq used as background job worker
  * Redis used for caching purposes.

* Run locally instructions
  * Import CSV data to local DB
    * ```rake import:merchant:push```
    * ```rake import:order:push```
    * These import schedule local task to run when scheduled time arrived
      * To run them now without waiting schedule time.
      ```
        tasks = ScheduledTask.all 
        tasks.each do |task|
          DisbursementJob.perform_later(task)
        end
      ```
  * Produce report
    ```
    rake report:disbursement:yearly
    ```
