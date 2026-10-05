#!/usr/bin/env bash
# Dựng repo thực hành: 1 commit nền + 4 commit theo đề bài (nhánh feature/auth)
set -e
DIR="${1:-$HOME/git-lab-ex2}"
rm -rf "$DIR" && mkdir -p "$DIR" && cd "$DIR"
git init -q -b main
git config user.name  >/dev/null || git config user.name  "Hoc Vien"
git config user.email >/dev/null || git config user.email "hocvien@example.com"

echo "# Project" > README.md
git add . && git commit -q -m "chore: init project"
git checkout -q -b feature/auth

# Commit 1
cat > auth.js <<'JS'
function login(user, pass) {
  return user === "admin" && pass === "123";
}
module.exports = { login };
JS
git add auth.js && git commit -q -m "feat: khoi tao module auth"

# Commit 2
sed -i 's/pass === "123"/pass === "123456"/' auth.js
git commit -qam "fix typo"

# Commit 3
cat >> auth.js <<'JS'

function logout() { return true; }
function isValidPassword(p) { return p.length >= 6; }
module.exports.logout = logout;
module.exports.isValidPassword = isValidPassword;
JS
git commit -qam "adds utility functions"

# Commit 4
echo "debug data" > temp.txt
git add temp.txt && git commit -q -m "add temp file for debug"

echo; echo ">>> Repo thuc hanh tai: $DIR"
echo ">>> Lich su TRUOC rebase:"; git log --oneline
