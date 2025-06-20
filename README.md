# Sui Quest

SuiQuest is a platform where event organizers (like SUI on Campus leads) can create interactive learning quests with tasks, questions, and time-limited challenges. Participants complete the tasks and earn NFTs as proof of achievement — gamifying education with Web3.


## 🎯 Project Name: SuiQuest

**Type:** Web3 learning + event platform  
**Built For:** SUI on Campus, Student Communities, Blockchain Educators


## 🧠 Core Idea

SuiQuest enables **event organizers** to create interactive learning quests. Each quest consists of tasks, questions, and time-limited challenges. **Participants** complete these tasks to earn **NFTs as proof of achievement**, making education engaging and verifiable on-chain.



### For Organizers

- Sign in with wallet/email
- Create an **event** with:
  - Title
  - Tasks/questions (milestones)
  - Duration
- Set a start time
- Track top participants and completions

### For Participants

- Join via wallet/email
- Complete tasks within the time limit
- Earn **NFTs for each milestone**
- Earn a **grand badge NFT** for completing all tasks
- Appear on a **leaderboard**


## 🛠️ Tech Stack

- **Frontend:** React, TailwindCSS, `@suiet/wallet-kit`, `@mysten/sui.js`
- **Backend/Blockchain:** Move smart contracts (Sui Blockchain)
- **Smart Contracts:**
  - Event creation, start, submission
  - NFT minting (task NFT + final badge)


## 🔥 Why It’s Unique

- Blends **education, gamification, and NFTs**
- Built entirely on the **Sui blockchain**
- Lets anyone create **quiz-based, on-chain learning events**
- Makes it fun for students to learn Web3 while earning verifiable badges


## Prerequisites

- [Node.js](https://nodejs.org/) (v16 or higher recommended)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [Sui CLI](https://docs.sui.io/sui-cli) (if interacting with Sui blockchain)

## Installation

1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd sui_quest
   ```

2. **Install dependencies:**
   ```sh
   npm install
   # or
   yarn install
   ```

## How to Run

- **Start the project:**
  ```sh
  npm start
  # or
  yarn start
  ```

- **Run tests:**
  ```sh
  npm test
  # or
  yarn test
  ```

- **Build for production:**
  ```sh
  npm run build
  # or
  yarn build
  ```

## Project Structure

- `src/` - Main source code directory
- `README.md` - Project documentation
- `package.json` - Project configuration and scripts
