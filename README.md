# README

## Requirements

- Ruby 3.2.3 (zalecane przez `rbenv`)
- Bundler

---

## Installation setup

Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Milosz-cat/device_registry.git
   cd device_registry
   ```

2. **Install Ruby 3.2.3 using rbenv:**

    ```bash
    rbenv install 3.2.3
    rbenv global 3.2.3
    ```

## ## Setup verification (important requirement):

To ensure that required steps are completed successfully you can run following commands:

1.  **Setting up the proper Ruby version:**

    ```bash
    rbenv version # expected --> 3.2.3 (set by /home/milosz/projects/RubyOnRails/device_registry/.ruby-version)
    ```

2.  **Running bundle install:**

    ```bash
    gem install bundler
    bundle install # expected --> Bundle complete! X Gemfile dependencies, Y gems now installed.
    ```  
    
3.  **Running rspec spec:**

    ```bash
    rspec # expected -->
    ```

4.  **Running rake db:test:prepare:**

    ```bash
    rake db:test:prepare: # expected --> Nothing :)
    ```

## Usage

1.  **Start the Rails server:**

    ```bash
    rails server
    # or shortcut
    rails s
    ```

The app should now be running at: http://localhost:3000

## Minimum Viable Product