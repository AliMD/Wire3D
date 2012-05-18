VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10365
   LinkTopic       =   "Form1"
   ScaleHeight     =   4995
   ScaleWidth      =   10365
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   8040
      TabIndex        =   4
      Top             =   2160
      Width           =   1215
   End
   Begin RichTextLib.RichTextBox rt 
      Height          =   3855
      Left            =   120
      TabIndex        =   3
      Top             =   600
      Width           =   7335
      _ExtentX        =   12938
      _ExtentY        =   6800
      _Version        =   393217
      ScrollBars      =   3
      Appearance      =   0
      TextRTF         =   $"Parser.frx":0000
   End
   Begin VB.CommandButton st 
      Caption         =   "Start ..."
      Height          =   375
      Left            =   7080
      TabIndex        =   2
      Top             =   120
      Width           =   975
   End
   Begin VB.CommandButton br 
      Caption         =   "..."
      Height          =   375
      Left            =   6480
      TabIndex        =   1
      Top             =   120
      Width           =   375
   End
   Begin VB.TextBox tx 
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Text            =   "E:\ALI\3D in flash\obj1m.txt"
      Top             =   120
      Width           =   6255
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
MsgBox (rt.SelLength)
End Sub

Private Sub st_Click()
rt.LoadFile (tx)
ps = rt.Find("*MESH_VERTEX_LIST {", 0) + 22
pe = rt.Find(Chr(9) + Chr(9) + "}", ps)
vt = Mid(rt.Text, ps, pe - ps)
vt = Replace(vt, Chr(9) + Chr(9) + Chr(9) + "*MESH_VERTEX", "P")
vt = Replace(vt, Chr(9), ",")
ps = rt.Find("*MESH_FACE_LIST {", 1) + 20
pe = rt.Find(Chr(9) + Chr(9) + "}", ps)
fc = Mid(rt.Text, ps, pe - ps)
fc = Replace(fc, Chr(9) + Chr(9) + Chr(9) + "*MESH_FACE", "F")
fc = Replace(fc, Chr(9), ",")
fc = Replace(fc, " ", ",")
Do
fc = Replace(fc, ",,", ",")
If fc = Replace(fc, ",,", ",") Then Exit Do
Loop
fc = Replace(fc, "AB:,", "")
fc = Replace(fc, "BC:,", "")
fc = Replace(fc, "CA:,", "")
fc = Replace(fc, "A:,", "")
fc = Replace(fc, "B:,", "")
fc = Replace(fc, "C:,", "")

'fc = Replace(fc, "A:,", "")
rt.Text = fc
End Sub
