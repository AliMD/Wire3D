Option Strict Off
Option Explicit On
Friend Class FRMMAIN
	Inherits System.Windows.Forms.Form
    Dim RE As New System.Text.RegularExpressions.Regex("\*MESH_VERTEX\s+\d+\s+[-|\d][.|\d].*")
	
	
	Private Sub BTN_Convert_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles BTN_Convert.Click
        Dim i As Integer = 0
        Dim MV As System.Text.RegularExpressions.MatchCollection
        Dim MV2 As System.Text.RegularExpressions.Match
		
		'RE.Pattern = "\*MESH_VERTEX\s+\d\s+\w+\.\d+\s+\d+\.\d+\s+\d+\.\d+"
        'RE.Pattern = "\*MESH_VERTEX\s+\d+\s+[-|\d][.|\d].*"
		
        'MV = RE.Execute(TBX.Text)
		
        For Each MV2 In RE.Matches(TBX.Text, "\*MESH_VERTEX\s+\d+\s+[-|\d][.|\d].*")
            'RE.Pattern = "\t"
            'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            TBX_Out.Text = TBX_Out.Text & "&P" & Str(i) & "=" & Mid(RE.Replace(MV2.Value, ","), 19, MV2.Length - 19) & "&" & vbNewLine
            'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            i = i + 1
        Next MV2
		
        'RE.Pattern = "\*MESH_FACE\s+\d+\:\s+A:\s+\d+ B:\s+\d+ C:\s+\d+ AB:\s+\d+ BC:\s+\d+ CA:\s+\d+"
        'MV = RE.Execute(TBX.Text)
		'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		i = 0
        For Each MV2 In RE.Matches(TBX.Text, "\*MESH_FACE\s+\d+\:\s+A:\s+\d+ B:\s+\d+ C:\s+\d+ AB:\s+\d+ BC:\s+\d+ CA:\s+\d+")
            'RE.Pattern = "\s+\w+\:"
            'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            TBX_Out.Text = TBX_Out.Text & "&F" & Str(i) & "=" & Mid(RE.Replace(MV2.Value, ","), 15) & "&" & vbNewLine
            'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            i = i + 1
        Next MV2
		
		TBX_Out.Text = Replace(TBX_Out.Text, " ", "")
		TBX_Out.SaveFile(Me.TBX_Path.Text & "2", Windows.Forms.RichTextBoxStreamType.PlainText)
		
	End Sub
	
	Private Sub Command1_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Command1.Click
		On Error GoTo 10
		DLGOpen.ShowDialog()
		Me.TBX_Path.Text = DLGOpen.FileName
        TBX.LoadFile(TBX_Path.Text, Windows.Forms.RichTextBoxStreamType.PlainText)
10: 
	End Sub
	
End Class