# Loan Book Management System

A Rails application for managing loan payments with multi-user access control.

## Features

- User authentication with Devise
- Loan book creation and management
- Loan payment tracking with due date alerts
- Document attachments
- Multi-user collaboration with permission levels
- Responsive Tailwind CSS design

## Prerequisites

- Ruby 3.2.2
- Rails 7.0.8
- PostgreSQL 14+
- Node.js 18+
- Yarn

## 🚀 Quick Start Commands

### Setup Commands
```bash
# Clone repository
git clone https://github.com/CHABDULQUDOOS682/loan_book.git
cd loan_book

# Install Ruby dependencies
bundle install

# Install JavaScript dependencies for Tailwind CSS
yarn install

# Setup database (PostgreSQL)
rails db:create
rails db:migrate
