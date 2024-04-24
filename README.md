# Whether Sweater

## Table of Contents
- [Getting Started](#getting-started)
- [Project Description](#project-description)
- [Learning Goals for Project](#learning-goals-for-project)
- [Setup](#setup)

## Getting Started
### Versions
- Ruby: 3.2.2
- Rails: 7.1.3

## Project Description
 This project exposes an API that satisfies the requirements for a Front End developer team, with a service-oriented architecture we are building an application to plan road trips.


<details>
  <summary>Learning Goals for Project</summary>
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
</details>

<details>
  <summary>Setup</summary>
  1. Fork and/or Clone this Repo from GitHub.
  2. In your terminal use `$ git clone <ssh or https path>`.
  3. Change into the cloned directory using `$ cd example`.
  4. Install the gem packages using `$ bundle install`.
  5. Database Migrations can be set up by running: 
  ``` bash 
  $ rails rake db:{drop,create,migrate,seed}
  ```
</details>

<details>
  <summary>Testing</summary>

  Test using the terminal utilizing RSpec:

  ```bash
  $ bundle exec rspec spec/<follow directory path to test specific files>
  ```

  or test the whole suite with `$ bundle exec rspec`
</details>

## External APIs/Services