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

### DB Schema

![ar_internal_metadata](https://github.com/whyarkadas/sequra/assets/38353086/4d687312-d836-4b2b-9e35-515f8269682d)

### Flow

* After merchant created I added a ScheduledTask for running disbursement of that user. This ScheduledTask is created using disbursement frequency of merchant so that we know when next time of that merchant's disbursement.
* I have a cron job running every day at 8 AM.ScheduledTaskJob cron job is checking ScheduledTask if there is any task that need to run.
* ScheduledTask contains list of task for merchant. This task is disbursement task for that merchant.
* Disbursement is done by MerchantDisbursementService for a Service. This service is checking orders of merchant that is not disbursed yet and add this order to disbursement.
* If disbursement service is running first time for a Merchant for that month I am checking monthly fee payments of that merchant if this is less than minimum monthlt fee for that merchant I added extra fee for that disbursement.