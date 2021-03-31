n=0
if [ ! -z $1 ]; then
        n=$1
fi

message_commit_hash=$(git rev-parse HEAD~$n)
reset_commit_hash=$(git rev-parse HEAD~$(($n + 1)))
commit_name=$(git log -n 1 --pretty=format:%s $message_commit_hash)

git reset --soft $reset_commit_hash &&
git commit -am "$commit_name"
