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
  * Run Sidekiq locally
    ```
     bundle exec sidekiq
    ```
  * Import CSV data to local DB
    * import merchant using provided merchant.csv
    ```
     rake import:merchant:push
    ```
    * import orders using provided orders.csv
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
### Possible TODO list
  * I fetched fee calculation params from ENV file about necessary limits however this can be done with dynamic way so fee calculation rules can be defined from a possible UI and read from DB. With this way user will have chance to change fee calculation rules whenever they want.
  * Need add more test especially for Service for edge cases or any extra validations.
  * Need more detailed instructions and documentation for project.
  * Possible we might need to have not only yearly report but also might need monthly report.

### DB Schema

![ar_internal_metadata](https://github.com/whyarkadas/sequra/assets/38353086/4d687312-d836-4b2b-9e35-515f8269682d)

### Flow

* After merchant created I added a ScheduledTask for running disbursement of that user. This ScheduledTask is created using disbursement frequency of merchant so that we know when next time of that merchant's disbursement.
* I have a cron job running every day at 8 AM.ScheduledTaskJob cron job is checking ScheduledTask if there is any task that need to run.
* ScheduledTask contains list of task for merchant. This task is disbursement task for that merchant.
* Disbursement is done by MerchantDisbursementService for a Service. This service is checking orders of merchant that is not disbursed yet and add this order to disbursement.
* If disbursement service is running first time for a Merchant for that month I am checking monthly fee payments of that merchant if this is less than minimum monthlt fee for that merchant I added extra fee for that disbursement.

* Producing report
  * To produce yearly report user just need to run just yearly report rake task(report:disbursement:yearly)

### Caching
* I am caching disbursement report for a period because it is better and faster way to provide reports for any case user is trying to run very report frequently and report do not change frequently it only can change daily.

### Technical Choose
* Choose to implement this project using Rails framework but it is not a must, we can go with just a simple Ruby project because this we do not need any UI or API. However because it is easier and faster way to have some basic functionality, going with Rails way is easier. Also we can go with Ruby project and just add and ORM(like ActiveRecord) and use it
* As persistence layer I choose to have Postgres because it is open source and provide enough amount of features for project needs.
* As background processor I choose Sidekiq because it most common and stable tool for Ruby project.

### Result

| Year |	Number of disbursements	| Amount disbursed to merchants	| Amount of order fees	| Number of monthly fees charged	| Amount of monthly fee charged |
| ---- | ---- | --- | ---- | ---- | --- |
| 2023	|10.391	|190.273.860,49	|1.709.260,98	|383	|8.646,86 |
| 2022	|1.509	|37.262.997,42	|333.677,15	|0	|0 |
