# README

## Requirements

- Ruby 3.2.3 (recommended by `rbenv`)
- Bundler

---

## Installation setup

### 1. **Clone the repository:**

```bash
git clone https://github.com/Milosz-cat/device_registry-assignment.git
cd device_registry-assignment
```

### 2. **Install rbenv (if not installed)**

#### Ubuntu/Debian:

 ```bash
 # Install rbenv
 git clone https://github.com/rbenv/rbenv.git ~/.rbenv

 # Add rbenv to PATH
 echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
 echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
 source ~/.bashrc

 # Install ruby-build plugin
 git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
 ```
#### macOS (using Homebrew):

 ```bash
 brew install rbenv
 ```

 ```bash
 # For zsh (default on macOS)
 echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
 echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
 source ~/.zshrc
 ```

 System restart may be required
 
### 3. **Install Ruby 3.2.3 using rbenv:**

 ```bash
 rbenv install 3.2.3
 rbenv global 3.2.3
 ```

### 4. **Install bundle using rbenv:**

 ```bash
 gem install bundler
 ```

## Setup verification (important requirements):

To ensure that required steps are completed successfully you can run following commands:

### 1.  **Setting up the proper Ruby version:**

   ```bash
   rbenv version # expected --> 3.2.3 (set by /home/milosz/projects/RubyOnRails/device_registry/.ruby-version)
   ```

### 2.  **Running bundle install:**

   ```bash
   bundle install # expected --> Bundle complete! X Gemfile dependencies, Y gems now installed.
   ```  

### 2.  **Running migration:**

   ```bash
    rails db:migrate
   ```  

### 3.  **Running rspec spec:**

   ```bash
   rspec # expected --> Finished in ... seconds ... 11 examples, 0 failures
   ```

### 4.  **Running rake db:test:prepare:**

   ```bash
   rake db:test:prepare # expected --> Nothing :)
   ```

## Usage

### 1.  **Start the Rails server:**

   ```bash
   rails server
   ```
   or shortcut
   ```bash
   rails s
   ```

The app should now be running at: http://127.0.0.1:3000

## Minimum Viable Product

### Core Requirements (Implemented)
- User can assign the device only to themself.
- User can't assign the device already assigned to another user.
- Only the user who assigned the device can return it.
- If the user returned the device in the past, they can't ever re-assign the same device to themself.

### Additional Features (Implemented)
- List Assigned Devices per User
- Device Ownership History
- Device Assignment Limit per User
- API Documentation (available at `http://localhost:3000/api-docs`)

## API Documentation

Interactive documentation is available at http://localhost:3000/api-docs

How to regenerate Swagger documentation:

   ```bash
   rake rswag:specs:swaggerize
   ```

 Remeber you must start the Rails server before that.

