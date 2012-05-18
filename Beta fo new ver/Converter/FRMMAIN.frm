VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRMMAIN 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Converter"
   ClientHeight    =   9240
   ClientLeft      =   2160
   ClientTop       =   2775
   ClientWidth     =   10995
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9240
   ScaleWidth      =   10995
   ShowInTaskbar   =   0   'False
   Begin MSComDlg.CommonDialog DLG 
      Left            =   5640
      Top             =   2040
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
      DialogTitle     =   "Load File"
   End
   Begin VB.CommandButton BTN_Convert 
      Caption         =   "Convert"
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   480
      Width           =   10695
   End
   Begin VB.TextBox TBX_Path 
      Height          =   285
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   10215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "..."
      Height          =   255
      Left            =   10440
      TabIndex        =   1
      Top             =   120
      Width           =   375
   End
   Begin RichTextLib.RichTextBox TBX 
      Height          =   4335
      Left            =   120
      TabIndex        =   0
      Top             =   960
      Width           =   10695
      _ExtentX        =   18865
      _ExtentY        =   7646
      _Version        =   393217
      ScrollBars      =   3
      TextRTF         =   $"FRMMAIN.frx":0000
   End
   Begin RichTextLib.RichTextBox TBX_Out 
      Height          =   3735
      Left            =   120
      TabIndex        =   3
      Top             =   5400
      Width           =   10695
      _ExtentX        =   18865
      _ExtentY        =   6588
      _Version        =   393217
      ScrollBars      =   3
      TextRTF         =   $"FRMMAIN.frx":0082
   End
End
Attribute VB_Name = "FRMMAIN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim RE As New VBScript_RegExp_55.RegExp


Private Sub BTN_Convert_Click()
Dim MV As Object
Dim MV2 As VBScript_RegExp_55.Match

'RE.Pattern = "\*MESH_VERTEX\s+\d\s+\w+\.\d+\s+\d+\.\d+\s+\d+\.\d+"
RE.Pattern = "\*MESH_VERTEX\s+\d+\s+[-|\d][.|\d].*"

Set MV = RE.Execute(TBX.Text)

For Each MV2 In MV
    RE.Pattern = "\t"
    TBX_Out.Text = TBX_Out.Text + "&P" + Str$(i) + "=" + Mid(RE.Replace(MV2.Value, ","), 19, MV2.Length - 19) + "&" + vbNewLine
    i = i + 1
Next

RE.Pattern = "\*MESH_FACE\s+\d+\:\s+A:\s+\d+ B:\s+\d+ C:\s+\d+ AB:\s+\d+ BC:\s+\d+ CA:\s+\d+"
Set MV = RE.Execute(TBX.Text)
i = 0
For Each MV2 In MV
    RE.Pattern = "\s+\w+\:"
    TBX_Out.Text = TBX_Out.Text + "&F" + Str$(i) + "=" + Mid(RE.Replace(MV2.Value, ","), 15) + "&" + vbNewLine
    i = i + 1
Next

TBX_Out.Text = Replace(TBX_Out.Text, " ", "")
TBX_Out.SaveFile Me.TBX_Path.Text + "2", rtfText

End Sub

Private Sub Command1_Click()
On Error GoTo 10
DLG.ShowOpen
Me.TBX_Path.Text = DLG.FileName
TBX.LoadFile TBX_Path.Text, rtfText
10 End Sub

Private Sub Form_Load()
RE.Global = True
End Sub




