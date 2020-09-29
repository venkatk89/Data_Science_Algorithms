
# coding: utf-8

# In[31]:


import cv2
import numpy as np
import matplotlib.pyplot as plt
import logging


# In[32]:


'''
Define a class of lines in python (vertex points define a line here not slope and intersect)
    Attributes:
        point: defined by vertices (x1, y1), (x2, y2)
        (mid_x, mid_y) : midpoint

'''
class Line:
    def __init__(self, l):
        self.points = l
        x1, y1, x2, y2 = l
        self.mid_x = (x1 + x2) / 2
        self.mid_y = (y1 + y2) / 2


# In[33]:


def line_intersection(l1, l2):
    """Function to get find intersection point of two line segments, given their end points.

    Args:
        l1 : line 1, an object of line class
        l2 : line 2, an object of line class

    Returns:
        intr : tuple containing coordinates of intersection point

    """
    x1, y1, x2, y2 = l1.points
    x3, y3, x4, y4 = l2.points
    
    a1 = y2 - y1           
    b1 = x1 - x2
    c1 = (x1 * a1) + (y1 * b1)      # later multiplied to obtain intersecting x coordinate
    
    a2 = y4 - y3
    b2 = x3 - x4
    c2 = (x3 * a2) + (y3 * b2)      # later multiplied to obtain intersecting y coordinate
    
    det = (b2 *a1) - (b1 * a2)
    
    if det == 0:
        print("No intersecting lines found")
    
    x_intr = 1.0 * ((b2 * c1) - (b1 * c2)) / det # multiplied with 1.0 to get float type
    y_intr = 1.0 * ((a1 * c2) - (a2 * c1)) / det
    
    return (x_intr, y_intr)


# In[41]:


def image_processing(image):
    """Function for cam-scanner.

    Args:
        image : image taken from the path

    Returns:
        new_image : image after processing

    """
    
    #looping starts
    pixel_count = 100000
    loop_count = 0
    while (pixel_count > 7500) and (loop_count < 4): # 100 pixels of 75 intensity and 4 loops allowed
        logging.info(": %d loop starts:", loop_count)
    
        height, width, color = image.shape

        # resizing the image to standard size

        min_width = 300
        scale = min(10.0, (1.0 * width)/min_width) # scaling more than 10 times is not advisable

        new_height = int(height * 1.0 / scale) # scaling height
        new_width = int(width * 1.0 / scale)   # scaling width  

        resized_image = cv2.resize(image, (new_width, new_height)) # resizing image

        grey_image = cv2.cvtColor(resized_image, cv2.COLOR_BGR2GRAY) # grayscaling image

    
        # gaussianblur is a filter used to reduce high frequencies
        gray_image = cv2.GaussianBlur(grey_image, (3,3), 0)

    
        # OTSU thresholding for bimodal image - to get minval and maxval for canny edge detection
        high_threshold, _ = cv2.threshold(gray_image, 0, 255,
                                          cv2.THRESH_BINARY |
                                          cv2.THRESH_OTSU)

        low_threshold = 0.5*high_threshold
    
    
        # canny edge detction
        canny_image = cv2.Canny(gray_image, low_threshold, high_threshold)

    
        # Hough line detection
        lines = cv2.HoughLinesP(canny_image,1, np.pi/180, new_width//3, None, new_width//3, 20)
                               #(image_name,1, value of pi, threshold, minLineLength, maxLineGap)

    
        # getting vertical and horizontal lines and draw it in image
        line_image = cv2.cvtColor(canny_image, cv2.COLOR_GRAY2BGR)

        horizontal = []
        vertical = []

        if lines is not None:
            for line_list in lines:
                for line in line_list:
                    x1, y1, x2, y2 = line
        
                    if abs(y2 - y1) > abs(x2 - x1):
                        vertical.append(Line(line))
                    else:
                        horizontal.append(Line(line))
                    cv2.line(line_image, (x1, y1), (x2, y2), (0, 255, 0), 1)

    
        # take image boundaries as output boundaries if enough lines are not detected
        if len(horizontal) < 2:
            if not horizontal or horizontal[0].mid_y > new_height / 2:
                horizontal.append(Line((0, 0, new_width - 1, 0)))
            if not horizontal or horizontal[0].mid_y <= new_height / 2:
                horizontal.append(Line((0, new_height - 1, new_width - 1, new_height - 1 )))

        if len(vertical) < 2:
            if not vertical or vertical[0].mid_x > new_width / 2:
                vertical.append(Line((0, 0, 0, new_height)))
            if not vertical or vertical[0].mid_x <= new_width / 2:
                vertical.append(Line((new_width - 1, 0, new_width - 1, new_height - 1)))
        
    
        # sort lines to select extreme lines to crop
        horizontal.sort(key = lambda l: l.mid_y)
        vertical.sort(key = lambda l: l.mid_x)  # lambda to define a nameless function inside sort

        edge_line_image = cv2.cvtColor(canny_image, cv2.COLOR_GRAY2BGR) # grayscaling

        for line in [horizontal[0], vertical[0], horizontal[-1], vertical[-1]]:
            x1, y1, x2, y2 = line.points
            cv2.line(edge_line_image, (x1, y1), (x2, y2), (0, 255, 0), 1) # drawing lines in image
    
    
        # finding intersecting points of extremes
        intersection_points = [line_intersection(horizontal[0], vertical[0]),
                               line_intersection(horizontal[0], vertical[-1]),
                               line_intersection(horizontal[-1], vertical[0]),
                               line_intersection(horizontal[-1], vertical[-1])]
    
    
        # plotting circles in intersection point
        for i, p in enumerate(intersection_points):
            x ,y = p
            intersection_points[i] = (x * scale, y * scale)
            cv2.circle(line_image, (int(x), int(y)), 3, (255, 255, 0), 3)

    
        # applying perspective transform with four corner points to get a4 size image
        a4_width = 2480
        a4_height = 3508

        a4_corners = ((0, 0), (a4_width - 1, 0), (0, a4_height - 1), (a4_width, a4_height))

        intersection_points = np.array(intersection_points, np.float32)
        a4_corners = np.array(a4_corners, np.float32)

        transformation_matrix = cv2.getPerspectiveTransform(intersection_points, a4_corners)

        out_image = cv2.warpPerspective(image, transformation_matrix, (a4_width, a4_height))

        new_image = cv2.cvtColor(out_image, cv2.COLOR_BGR2GRAY)
        _, new_image = cv2.threshold(new_image, 200, 255, cv2.THRESH_TRUNC)
                                  #(grayScaleImage, thresholdValue, maxValue, typeOfThreshold)

        new_image = cv2.cvtColor(new_image, cv2.COLOR_GRAY2RGB)

    
        #masking to get boundary information
        mask = np.zeros((a4_height, a4_width), np.uint8)

        mask[0:50, 0:a4_width] = 255
        mask[0:a4_height, 0:50] = 255
        mask[(a4_height - 50):a4_height, 0:a4_width] = 255
        mask[0:a4_height, (a4_width - 50):a4_width] = 255

    
        # creating histogram info
        hist_mask = cv2.calcHist([new_image], [0], mask, [256], [0, 256])

    
        # updating count
        pixel_count = 0
        for i in range(256):
            if(new_image.ravel()[i] < 75):
                pixel_count = pixel_count + hist_mask[i][0]
        logging.info(": %d pixel count:", pixel_count)
    
    
        # updating looping count
        logging.info(": %d loop ends", loop_count )
        loop_count = loop_count + 1
    
        # updating image
        image = new_image
        
    return new_image


# In[42]:


def main(path):
    logging.basicConfig(filename='image_processing.log',
                        format='%(asctime)s %(message)s',
                        datefmt='%m/%d/%Y %I:%M:%S %p',
                        level=logging.INFO
                        )
    logging.info(": code starts")
    
    # reading an image
    image = cv2.imread(path, 1) # 1 for rgb, 0 for greyscale
    logging.info(": image read.")
    
    # processing the image to crop the papper
    new_image = image_processing(image)
    logging.info(": image processed.")
    
    # create new filename
    file_name = path[:-4]
    new_file = file_name + "_processed.jpg"
    
    # write image
    cv2.imwrite(new_file, new_image)
    
    logging.info(": image written.")
    logging.info(": code ends. \n")
    
    

