echo "Staring backing up..."
echo "aliases, history and ENV..."
rsync /home/$USER/.zsh_aliases /media/ndt/Data1/backups/home/$USER/.zsh_aliases
rsync /home/$USER/.zsh_history /media/ndt/Data1/backups/home/$USER/.zsh_history
rsync /home/$USER/.env_variables /media/ndt/Data1/backups/home/$USER/.env_variables

echo "ssh config..."
rsync /home/$USER/.ssh/config /media/ndt/Data1/backups/home/$USER/.ssh/config

echo "aws config..."
rsync /home/$USER/.aws/config /media/ndt/Data1/backups/home/$USER/.aws/config
rsync /home/$USER/.aws/credentials /media/ndt/Data1/backups/home/$USER/.aws/credentials

echo "kube config..."
rsync /home/$USER/.kube/config /media/ndt/Data1/backups/home/$USER/.kube/config

echo "directory '~/Dics'"
rsync -r /home/$USER/Dics /media/ndt/Data1/backups/home/$USER/
