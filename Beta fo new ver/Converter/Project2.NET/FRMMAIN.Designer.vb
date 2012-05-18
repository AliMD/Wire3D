<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class FRMMAIN
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public DLGOpen As System.Windows.Forms.OpenFileDialog
	Public WithEvents BTN_Convert As System.Windows.Forms.Button
	Public WithEvents TBX_Path As System.Windows.Forms.TextBox
	Public WithEvents Command1 As System.Windows.Forms.Button
	Public WithEvents TBX As System.Windows.Forms.RichTextBox
	Public WithEvents TBX_Out As System.Windows.Forms.RichTextBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(FRMMAIN))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.DLGOpen = New System.Windows.Forms.OpenFileDialog
		Me.BTN_Convert = New System.Windows.Forms.Button
		Me.TBX_Path = New System.Windows.Forms.TextBox
		Me.Command1 = New System.Windows.Forms.Button
		Me.TBX = New System.Windows.Forms.RichTextBox
		Me.TBX_Out = New System.Windows.Forms.RichTextBox
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		Me.Text = "Converter"
		Me.ClientSize = New System.Drawing.Size(733, 616)
		Me.Location = New System.Drawing.Point(144, 185)
		Me.MaximizeBox = False
		Me.MinimizeBox = False
		Me.ShowInTaskbar = False
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.ControlBox = True
		Me.Enabled = True
		Me.KeyPreview = False
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "FRMMAIN"
		Me.DLGOpen.Title = "Load File"
		Me.BTN_Convert.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.BTN_Convert.Text = "Convert"
		Me.BTN_Convert.Size = New System.Drawing.Size(713, 25)
		Me.BTN_Convert.Location = New System.Drawing.Point(8, 32)
		Me.BTN_Convert.TabIndex = 4
		Me.BTN_Convert.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.BTN_Convert.BackColor = System.Drawing.SystemColors.Control
		Me.BTN_Convert.CausesValidation = True
		Me.BTN_Convert.Enabled = True
		Me.BTN_Convert.ForeColor = System.Drawing.SystemColors.ControlText
		Me.BTN_Convert.Cursor = System.Windows.Forms.Cursors.Default
		Me.BTN_Convert.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.BTN_Convert.TabStop = True
		Me.BTN_Convert.Name = "BTN_Convert"
		Me.TBX_Path.AutoSize = False
		Me.TBX_Path.Size = New System.Drawing.Size(681, 19)
		Me.TBX_Path.Location = New System.Drawing.Point(8, 8)
		Me.TBX_Path.TabIndex = 2
		Me.TBX_Path.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TBX_Path.AcceptsReturn = True
		Me.TBX_Path.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.TBX_Path.BackColor = System.Drawing.SystemColors.Window
		Me.TBX_Path.CausesValidation = True
		Me.TBX_Path.Enabled = True
		Me.TBX_Path.ForeColor = System.Drawing.SystemColors.WindowText
		Me.TBX_Path.HideSelection = True
		Me.TBX_Path.ReadOnly = False
		Me.TBX_Path.Maxlength = 0
		Me.TBX_Path.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.TBX_Path.MultiLine = False
		Me.TBX_Path.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.TBX_Path.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.TBX_Path.TabStop = True
		Me.TBX_Path.Visible = True
		Me.TBX_Path.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TBX_Path.Name = "TBX_Path"
		Me.Command1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.Command1.Text = "..."
		Me.Command1.Size = New System.Drawing.Size(25, 17)
		Me.Command1.Location = New System.Drawing.Point(696, 8)
		Me.Command1.TabIndex = 1
		Me.Command1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Command1.BackColor = System.Drawing.SystemColors.Control
		Me.Command1.CausesValidation = True
		Me.Command1.Enabled = True
		Me.Command1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Command1.Cursor = System.Windows.Forms.Cursors.Default
		Me.Command1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Command1.TabStop = True
		Me.Command1.Name = "Command1"
		Me.TBX.Size = New System.Drawing.Size(713, 289)
		Me.TBX.Location = New System.Drawing.Point(8, 64)
		Me.TBX.TabIndex = 0
		Me.TBX.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Both
		Me.TBX.RTF = resources.GetString("TBX.TextRTF")
		Me.TBX.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TBX.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TBX.Name = "TBX"
		Me.TBX_Out.Size = New System.Drawing.Size(713, 249)
		Me.TBX_Out.Location = New System.Drawing.Point(8, 360)
		Me.TBX_Out.TabIndex = 3
		Me.TBX_Out.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Both
		Me.TBX_Out.RTF = resources.GetString("TBX_Out.TextRTF")
		Me.TBX_Out.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.TBX_Out.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.TBX_Out.Name = "TBX_Out"
		Me.Controls.Add(BTN_Convert)
		Me.Controls.Add(TBX_Path)
		Me.Controls.Add(Command1)
		Me.Controls.Add(TBX)
		Me.Controls.Add(TBX_Out)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class