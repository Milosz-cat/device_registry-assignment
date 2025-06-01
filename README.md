# README

## Requirements

- Ruby 3.2.3 (recommended by `rbenv`)
- Bundler

---

## Installation setup

Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Milosz-cat/device_registry.git
   cd device_registry
   ```

2. **Install rbenv (if not installed):**

    ```bash
    # Ubuntu/Debian
    sudo apt install rbenv ruby-build
    ```

    ```bash
    # macOS (Homebrew)
    brew install rbenv

### Initialize rbenv (depending on your shell)

    ```bash
    # For bash (Linux default)
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
    source ~/.bashrc
    ```

    ```bash
    # For zsh (macOS default)
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
    source ~/.zshrc
    ```

3. **Install Ruby 3.2.3 using rbenv:**

    ```bash
    rbenv install 3.2.3
    rbenv global 3.2.3
    ```

4. **Install bundle using rbenv:**

    ```bash
    gem install bundler
    ```

## Setup verification (important requirements):

To ensure that required steps are completed successfully you can run following commands:

1.  **Setting up the proper Ruby version:**

    ```bash
    rbenv version # expected --> 3.2.3 (set by /home/milosz/projects/RubyOnRails/device_registry/.ruby-version)
    ```

2.  **Running bundle install:**

    ```bash
    bundle install # expected --> Bundle complete! X Gemfile dependencies, Y gems now installed.
    ```  
    
3.  **Running rspec spec:**

    ```bash
    rspec # expected --> Finished in ... seconds ... 11 examples, 0 failures
    ```

4.  **Running rake db:test:prepare:**

    ```bash
    rake db:test:prepare # expected --> Nothing :)
    ```

## Usage

1.  **Start the Rails server:**

    ```bash
    rails server
    # or shortcut
    rails s
    ```

The app should now be running at: http://127.0.0.1:3000

## Minimum Viable Product