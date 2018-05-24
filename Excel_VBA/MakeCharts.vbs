Sub MakeCharts()

    Dim sh As Worksheet

    Dim rAllData As Range

    Dim rChartData As Range

    Dim cl As Range

    Dim rwStart As Long, rwCnt As Long

    Dim chrt As Chart

    Dim i As Variant

   

    i = 0



    Set sh = ActiveSheet



    With sh

        ' Get reference to all data

        Set rAllData = .Range(.[A1], .[A1].End(xlDown)).Resize(, 4)

        ' Get reference to first cell in data range

        rwStart = 2

        Set cl = rAllData.Cells(rwStart, 1)

        Dim h As Variant

        Do While cl <> ""

            Dim height As Variant

            Dim width As Variant

            ' cl points to first cell in a station data set

            ' Count rows in current data set

            rwCnt = Application.WorksheetFunction. _

               CountIfs(rAllData.Columns(1), cl.Value)

            ' Get reference to current data set range

            Set rChartData = rAllData.Cells(rwStart, 1).Resize(rwCnt, 4)

            ' Create Chart next to data set

            If i = 0 Then

                h = Range(.[A1], cl).height

                width = rChartData.width

                height = h

            ElseIf i Mod 2 <> 0 Then

                width = rChartData.width + 720

                height = h

            Else

                width = rChartData.width

                height = h + 360

                h = height

            End If

            Set chrt = .Shapes.AddChart(xlXYScatterLines, _

               width, height, 720, 360).Chart

            With chrt

                .SetSourceData Source:=rChartData.Offset(0, 1).Resize(, 3)

                ' --> Set any chart properties here

                

                ' Add Title

                .SetElement msoElementChartTitleCenteredOverlay

                .ChartTitle.Caption = cl.Value

                .Axes(xlValue).MinimumScale = -2

                .Axes(xlValue).MaximumScale = 12

                ' Adjust plot size to allow for title

                .PlotArea.height = .PlotArea.height - .ChartTitle.height

                .PlotArea.Top = .PlotArea.Top + .ChartTitle.height



                ' Name series'

                .SeriesCollection(1).Name = "=""CONFIDENCE"""

                .SeriesCollection(2).Name = "=""RELIABILITY"""

                

                .SeriesCollection(1).Format.Line.Weight = 5

                .SeriesCollection(2).Format.Line.Weight = 5

                

                ' turn off markers

                .SeriesCollection(1).MarkerStyle = -4142

                .SeriesCollection(2).MarkerStyle = -4142



            End With



            ' Get next data set

            rwStart = rwStart + rwCnt

            Set cl = rAllData.Cells(rwStart, 1)

            i = i + 1

        Loop



    End With



End Sub



