Imports System.Drawing.Imaging

Partial Class showImage
    Inherits System.Web.UI.Page


 
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Read in the image filename to create a thumbnail of
        Dim imageUrl As String = Request.QueryString("img")

        'Read in the width and height
        Dim maxHeight As Integer = Request.QueryString("h")
        Dim maxWidth As Integer = Request.QueryString("w")

      
        ' Make sure that the image URL doesn't contain any /'s or \'s
        If imageUrl.IndexOf("/") >= 0 Or imageUrl.IndexOf("\") >= 0 Then
            'We found a / or \
            Response.End()
        End If

        'Add on the appropriate directory
        'imageUrl = "prodimages/" & imageUrl
        Dim imgFolder As String = ""

        If Session("ClaimId") IsNot Nothing Then
            imgFolder = Session("ClaimId")
        Else
            Dim curSession As String = HttpContext.Current.Session.SessionID
            imgFolder = "Temp\" & curSession
        End If

        imageUrl = "Claims\" & imgFolder & "\" & imageUrl

        Dim fullSizeImg As System.Drawing.Image
        fullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(imageUrl))

        
        Dim imgHeight As Int16 = fullSizeImg.Height
        Dim imgWidth As Int16 = fullSizeImg.Width
        Dim scaleFactor As Double
        'If imgWidth > maxWidth Or imgHeight > maxHeight Then
        '    If (maxHeight / imgHeight) > (maxWidth / imgWidth) Then
        '        scaleFactor = maxHeight / imgHeight
        '    Else
        '        scaleFactor = maxWidth / imgWidth
        '    End If
        'End If

        'If imgWidth > maxWidth Then
        '    scaleFactor = maxWidth / imgWidth
        '    imgWidth *= scaleFactor
        '    imgHeight *= scaleFactor
        'End If

        'If imgHeight > maxHeight Then
        '    imgWidth /= scaleFactor
        '    imgHeight /= scaleFactor
        '    scaleFactor = maxHeight / imgHeight
        '    imgWidth *= scaleFactor
        '    imgHeight *= scaleFactor
        '    imgHeight /= scaleFactor
        '    scaleFactor = maxHeight / imgHeight
        '    imgWidth *= scaleFactor
        '    imgHeight *= scaleFactor
        'End If


        If maxWidth > 0 Then
            If imgHeight > imgWidth Then
                imgWidth = imgWidth / (imgHeight / maxWidth)
                imgHeight = maxWidth
            Else
                imgHeight = imgHeight / (imgWidth / maxWidth)
                imgWidth = maxWidth
            End If
        End If

        'Trace.Warn(Server.MapPath(imageUrl))
        'Do we need to create a thumbnail?
        Response.ContentType = "image/gif"
        If imgHeight > 0 And imgWidth > 0 Then
            Dim dummyCallBack As System.Drawing.Image.GetThumbnailImageAbort
            dummyCallBack = New _
               System.Drawing.Image.GetThumbnailImageAbort(AddressOf ThumbnailCallback)

            Dim thumbNailImg As System.Drawing.Image
            thumbNailImg = fullSizeImg.GetThumbnailImage(imgWidth, imgHeight, dummyCallBack, IntPtr.Zero)

            thumbNailImg.Save(Response.OutputStream, ImageFormat.Gif)

            'Clean up / Dispose...
            thumbNailImg.Dispose()
        Else
            fullSizeImg.Save(Response.OutputStream, ImageFormat.Gif)
        End If

        'Clean up / Dispose...
        fullSizeImg.Dispose()
    End Sub

    Function ThumbnailCallback() As Boolean
        Return False
    End Function

End Class
