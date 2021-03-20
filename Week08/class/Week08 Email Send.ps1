# Storyline: Send an email.

# Body of the email
# Variable can have an underscore or any alphanumeric value.

$msg = "Hello there, Professor Dunston."

# echoing to the screen.
write-host -BackgroundColor Red -ForegroundColor white $msg

# Email From Address
$email = "brendan.mckenney@mymail.champlain.edu"

# To address
$toEmail = "deployer@csi-web"

# Sending the email
Send-MailMessage -From $email -to $toEmail -Subject "A Greeting (Brendan McKenney)" -Body $msg -SmtpServer 192.168.6.71