<#

    SQL Form

#>


<# PROPERTIES #>
[int] $formWidth = 500
[int] $formHeight = 550
$editing = $false

# FUNCTION REFRESH TABLE
function Refresh-Table() {

    $usersListBox.Items.Clear();

    $query ="SELECT * FROM user"
    $dataAdapter = New-Object System.Data.SQLite.SQLiteDataAdapter($query, $connexion)
    $dataSet = New-Object System.Data.DataSet
    [void]$dataAdapter.Fill($dataSet)

    foreach($user in $dataSet.Tables[0]) {
        $usersListBox.Items.Add($user.Name) 
    }

}

function Clear-Input() {
        $userNameTextBox.Text = ""
        $userSurnameTextBox.Text = ""
        $userAgeTextBox.Text = ""
        $userNameTextBox.Enabled = $true

        $userCreateButton.Text = "Créer"

        $global:editing = $false
        $userEditButton.Enabled = $false
        $userDeleteButton.Enabled = $false
}

<# LOAD ASSEMBLY #>
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
Write-Host $PSScriptRoot
Add-Type -Path "$PSScriptRoot\System.Data.SQLite.DLL"
$connexionDatabase = "Data Source=$PSScriptRoot\sqlform.db"

$connexion = New-Object System.Data.SQLite.SQLiteConnection($connexionDatabase)
$connexion.Open()

$command = $connexion.CreateCommand()
$command.CommandText = "CREATE TABLE IF NOT EXISTS USER (Name VARCHAR(20) PRIMARY KEY, Surname VARCHAR(20), Age INT)"
$command.ExecuteNonQuery()
$command.Dispose()

$form = New-Object Windows.Forms.Form
$form.Text = "SQL Form"
$form.Size = New-Object System.Drawing.Size($formWidth,$formHeight)

<# USERS LAYOUT #>
$userLabel = New-Object System.Windows.Forms.Label
$userLabel.Text = 'Users list:'

$usersListBox = New-Object System.Windows.Forms.ListBox
$usersListBox.Anchor = 'Top,Left,Bottom,Right'

# FILL LIST BOX
Refresh-Table

$usersLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$usersLayout.RowCount = 2
$usersLayout.Controls.Add($userLabel, 0, 0);
$usersLayout.Controls.Add($usersListBox, 0, 1);
$usersLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

<# USER EDIT LAYOUT #>

#NAME
$userNameLabel = New-Object System.Windows.Forms.Label;
$userNameLabel.Text = "Nom :"

$userNameTextBox = New-Object System.Windows.Forms.TextBox;

$userNameLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$userNameLayout.ColumnCount = 2
$userNameLayout.Controls.Add($userNameLabel, 0, 0);
$userNameLayout.Controls.Add($userNameTextBox, 1, 0);
$userNameLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

#SURNAME
$userSurnameLabel = New-Object System.Windows.Forms.Label;
$userSurnameLabel.Text = "Prénom :"

$userSurnameTextBox = New-Object System.Windows.Forms.TextBox;

$userSurnameLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$userSurnameLayout.ColumnCount = 2
$userSurnameLayout.Controls.Add($userSurnameLabel, 0, 0);
$userSurnameLayout.Controls.Add($userSurnameTextBox, 1, 0);
$userSurnameLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

#NAME
$userAgeLabel = New-Object System.Windows.Forms.Label;
$userAgeLabel.Text = "Age :"

$userAgeTextBox = New-Object System.Windows.Forms.TextBox;

$userAgeLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$userAgeLayout.ColumnCount = 2
$userAgeLayout.Controls.Add($userAgeLabel, 0, 0);
$userAgeLayout.Controls.Add($userAgeTextBox, 1, 0);
$userAgeLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

#BUTTON
$userCreateButton = New-Object System.Windows.Forms.Button;
$userCreateButton.Text = "Créer"

$userEditButton = New-Object System.Windows.Forms.Button;
$userEditButton.Text = "Modifier"
$userEditButton.Enabled = $false

$userDeleteButton = New-Object System.Windows.Forms.Button;
$userDeleteButton.Text = "Supprimer"
$userDeleteButton.Enabled = $false


$userButtonsLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$userButtonsLayout.ColumnCount = 3
$userButtonsLayout.Controls.Add($userCreateButton, 0, 0);
$userButtonsLayout.Controls.Add($userEditButton, 1, 0);
$userButtonsLayout.Controls.Add($userDeleteButton, 3, 0);
$userButtonsLayout.Dock = [System.Windows.Forms.DockStyle]::Fill

#LAYOUT
$userEditLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$userEditLayout.RowCount = 4
$userEditLayout.Controls.Add($userNameLayout);
$userEditLayout.Controls.Add($userSurnameLayout);
$userEditLayout.Controls.Add($userAgeLayout);
$userEditLayout.Controls.Add($userButtonsLayout);
$userEditLayout.Anchor = 'Top,Left,Bottom,Right'
$userEditLayout.Dock = [System.Windows.Forms.DockStyle]::Fill


<# MAIN LAYOUT #>
$mainLayout = New-Object System.Windows.Forms.TableLayoutPanel;
$mainLayout.ColumnCount = 2
$mainLayout.Controls.Add($usersLayout, 0, 0);
$mainLayout.Controls.Add($userEditLayout, 1, 0);
$mainLayout.Dock = [System.Windows.Forms.DockStyle]::Fill


<# EVENTS #>
# USERS LIST BOX CHANGE
$usersListBox.add_SelectedIndexChanged(
     { 
        $name = $usersListBox.SelectedItems 
         $query ="SELECT * FROM user WHERE Name = '$name'"
        $dataAdapter = New-Object System.Data.SQLite.SQLiteDataAdapter($query, $connexion)
        $dataSet = New-Object System.Data.DataSet
        [void]$dataAdapter.Fill($dataSet)
        $userNameTextBox.Text =  $dataSet.Tables[0].Rows[0].Name
        $userNameTextBox.Enabled = $false
        $userSurnameTextBox.Text =  $dataSet.Tables[0].Rows[0].Surname
        $userAgeTextBox.Text =  $dataSet.Tables[0].Rows[0].Age


        # Enable Button
        $userCreateButton.Text = "Ajouter nouveau"
        $global:editing = $true
        $userEditButton.Enabled = $true
        $userDeleteButton.Enabled = $true
     }
)

# CREATE CLICK
$userCreateButton.add_Click({
    
    if($global:editing -eq $true) {
        Clear-Input
    } else {
        $Name = $userNameTextBox.Text
        $Surname = $userSurnameTextBox.Text
        $Age = $userAgeTextBox.Text

        $command = $connexion.CreateCommand()
        $command.CommandText = "INSERT OR IGNORE INTO USER (Name, Surname, Age) VALUES ('$Name', '$Surname', $Age)"
        $command.ExecuteNonQuery()
        $command.Dispose()

        Refresh-Table
    }
})

# UPDATE 
$userEditButton.add_Click({
    
    $Name = $userNameTextBox.Text
    $Surname = $userSurnameTextBox.Text
    $Age = $userAgeTextBox.Text

    $command = $connexion.CreateCommand()
    $command.CommandText = "UPDATE user SET Surname = '$Surname', Age = '$Age' WHERE Name = '$Name'"
    $command.ExecuteNonQuery()
    $command.Dispose()

    Refresh-Table
})

# UPDATE 
$userDeleteButton.add_Click({
    
    $Name = $userNameTextBox.Text

    $command = $connexion.CreateCommand()
    $command.CommandText = "DELETE FROM user WHERE Name = '$Name'"
    $command.ExecuteNonQuery()
    $command.Dispose()

    Clear-Input

    Refresh-Table
})

#$mainLayout.Anchor = 'Top,Left,Bottom,Right'

$form.Controls.Add($mainLayout)
$form.Anchor = 'Top,Left,Bottom,Right'

$form.ShowDialog()