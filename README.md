# README

Disbursement calculation and build project for Sequra.

### System dependencies
  * Ruby version
    * 3.1.2
  * Rails version
    * 7.1.2
  * Check dependency details from Gemfile.
  

### Configuration
  * Rails project initalized as API only so could also be used to fetched data from remote.
  * Database creation
    ```$rake db:create```
  * Database initialization
    ```$rake db:migrate```
    
### Test
* Rspec used for unit testing.
  ```
  $export RAILS_ENV=test
  $rspec spec
  ```

### Services (job queues, cache servers)
  * Sidekiq used as background job worker
  * Redis used for caching purposes.
  

### Local run instructions
  * Import CSV data to local DB
    * import merchant using merchant.csv
    ```
     rake import:merchant:push
    ```
    * import orders using orders.csv
    ```
     rake import:order:push
    ```
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
