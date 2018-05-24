Option Compare Text
Sub Find_First()
Dim MergedEntName As String
Dim Rng As range
Dim myRange As String

MergedEntName = ""

    For i = 4 To 1131    ' Revise the 500 to include all of your values
        Dim currCelll As String
        currCell = Cells(i, 1).Value
        If currCell <> MergedEntName Then
            MergedEntName = currCell
            myRange = "Q" + CStr(i) + ":" + "BO" + CStr(i)
        Else
            Dim rang As String
            rang = "Q" + CStr(i) + ":" + "BO" + CStr(i)
            range(myRange).Copy range(rang)
        End If
    Next i
End Sub
