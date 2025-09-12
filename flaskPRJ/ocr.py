# import io
# import os
# from google.cloud import vision
#
#
# def doVisionOCR(iamgePath, resultPath ) :
#
#     print("imagePath : "+str(iamgePath))
#     print("resultPath : ")+str(resultPath)
#
#     os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'aducator-360005-edd0962be87c.json'
#
#     client_options = {'api_endpoint': 'eu-vision.googleapis.com'}
#     client = vision.ImageAnnotatorClient(client_options=client_options)
#
#     imagePath = iamgePath
#     with io.open(imagePath, 'rb') as image_file:
#         content = image_file.read()
#
#     image = vision.Image(content=content)
#
#     response = client.text_detection(image=image) # permission
#     texts = response.text_annotations
#
#     OcrText = str(texts[0].description)
#     print("원문 : " + OcrText)
#
#     f = open(resultPath,"w")
#     f.write(OcrText)
#     f.close()
#
#     if response.error.message:
#         raise Exception(
#             '{}\nFor more info on error messages, check: '
#             'https://cloud.google.com/apis/design/errors'.format(
#             response.error.message)
#
#     )
#
