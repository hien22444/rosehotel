
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <jsp:include page="components/head.jsp"></jsp:include>
            <style>
                .booking-btn {
                    display: inline-block;
                    font-size: 14px;
                    text-transform: uppercase;
                    padding: 12px 16px;
                    border: 1px solid #dfa974;
                    border-radius: 2px;
                    color: #dfa974;
                    font-weight: 500;
                    background: transparent;
                    height: 46px;
                    margin-top: 30px;
                }

                .booking-btn:hover {
                    background: #dfa974;
                    color: white;
                }

                .favorite-btn {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    font-size: 14px;
                    text-transform: uppercase;
                    padding: 12px 16px;
                    border: 1px solid #dfa974;
                    border-radius: 2px;
                    color: white;
                    font-weight: 500;
                    background: #dfa974;
                    height: 46px;
                    margin-top: 30px;
                }

                .favorite-btn:hover {
                    background: transparent;
                    color: #dfa974;
                }

                .rating-form {
                    display: flex;
                    align-items: center;
                    gap: 2px;
                }

                .rating-form * {
                    cursor: pointer;
                }

                .rating-form *.active {
                    color: gold;
                }
            </style>
        </head>

        <body>
        <jsp:include page="components/header.jsp"></jsp:include>
            <!-- Room Details Section Begin -->
            <section class="room-details-section spad">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="room-details-item">
                                <img style="width: 100%;height: 500px; object-fit: cover;"
                                     src="${requestScope.ROOM_DETAIL.roomTypesDTO.image}" alt="">
                            <div class="rd-text">
                                <div class="rd-title">
                                    <h3>${requestScope.ROOM_DETAIL.roomName}</h3>

                                    <div class="rdt-right">
                                        <c:if test="${requestScope.AVG_STAR != null}">
                                            <div class="rating" style="margin-right: 350px">

                                                <c:forEach begin="1" end="${requestScope.AVG_STAR}">

                                                    <i class="icon_star"></i>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                        <c:if test="${requestScope.AVG_STAR == 0}">
                                            <div class="rating " style="margin-right: 350px">
                                                <i class="icon_star"></i>
                                                <i class="icon_star"></i>
                                                <i class="icon_star"></i>
                                                <i class="icon_star"></i>
                                                <i class="icon_star-half_alt"></i>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <h2>${requestScope.ROOM_DETAIL.price}$<span>/Pernight</span></h2>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="r-o">Type:</td>
                                            <td>${requestScope.ROOM_DETAIL.roomTypesDTO.typeName}</td>
                                        </tr>
                                        <tr>
                                            <td class="r-o">Max persion: </td>
                                            <td>${requestScope.ROOM_DETAIL.roomTypesDTO.maxPeople}</td>
                                        </tr>
                                        <tr>
                                            <td class="r-o">Bed:</td>
                                            <td>${requestScope.ROOM_DETAIL.roomTypesDTO.bed} Beds</td>
                                        </tr>
                                        <tr>
                                            <td class="r-o">Services:</td>
                                            <td>${requestScope.ROOM_DETAIL.roomTypesDTO.utilities}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <p class="f-para">
                                    ${requestScope.ROOM_DETAIL.roomTypesDTO.discription}
                                </p>
                                <div class="d-flex">
                                    <a href="MainController?btnAction=viewDetailRoom&hotelId=0&roomNo=${requestScope.ROOM_DETAIL.roomNo}"
                                       class="booking-btn">Booking Now</a>
                                    <form action="ViewDetailRoom?roomNo=${requestScope.ROOM_DETAIL.roomNo}"
                                          method="Post">
                                        <button class="favorite-btn ml-2" name="isFavorite"
                                                value="${requestScope.FAVORITE}">
                                            <c:if test="${requestScope.FAVORITE}">
                                                <i class="fas fa-heart" style="color: red"></i> Unfavorite
                                            </c:if>
                                            <c:if test="${!requestScope.FAVORITE}">
                                                <i class="far fa-heart"></i> Favorite
                                            </c:if>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="rd-reviews">
                            <h4 class="d-flex align-items-center justify-content-between">
                                Reviews
                                <c:if test="${requestScope.CAN_REVIEW}">
                                    <button class="booking-btn" data-toggle="modal" data-target="#reviewModal">Write
                                    a review</button>
                                </c:if>
                            </h4>

                            <c:forEach var="feed" items="${requestScope.FEED_BACKS}">
                                <div class="review-item" style="height: 80px">
                                    <div class="ri-pic">
                                        <img src="img/room/avatar/avatar-1.jpg" alt="">
                                    </div>
                                    <div class="ri-text">
                                        <div class="rating">
                                            <c:forEach begin="1" end="${feed.value}">
                                                <i class="icon_star"></i>
                                            </c:forEach>
                                        </div>
                                        <h5>${feed.userDTO.name}</h5>
                                        <p>${feed.description}.</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div id="reviewModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${requestScope.FEEDBACK == null ? "FeedBackServlet" : "UpdateFeedback"}" method="POST">
                            <div class="modal-header">
                                <h4 class="modal-title">Write a review</h4>
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <p>Are you satisfied with this room?</p>
                                <div class="rating-form" style="margin-right: 350px" >
                                    <i class="icon_star ${requestScope.FEEDBACK.value == null || requestScope.FEEDBACK.value >= 1 ? "active" : ""}" data-value="1"></i>
                                    <i class="icon_star ${requestScope.FEEDBACK.value == null || requestScope.FEEDBACK.value >= 2 ? "active" : ""}" data-value="2"></i>
                                    <i class="icon_star ${requestScope.FEEDBACK.value == null || requestScope.FEEDBACK.value >= 3 ? "active" : ""}" data-value="3"></i>
                                    <i class="icon_star ${requestScope.FEEDBACK.value == null || requestScope.FEEDBACK.value >= 4 ? "active" : ""}" data-value="4"></i>
                                    <i class="icon_star ${requestScope.FEEDBACK.value == null || requestScope.FEEDBACK.value >= 5 ? "active" : ""}" data-value="5"></i>
                                </div>
                                <input type="hidden" name="roomNo" value="${param.roomNo}" />
                                <input type="hidden" name="value" id="rating-value"  value="${requestScope.FEEDBACK.value == null ? 5 : requestScope.FEEDBACK.value }" />
                                <textarea required name="description" rows="4" class="w-100 mt-3"><c:out value="${requestScope.FEEDBACK.description}" /></textarea>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal"
                                       value="Cancel">
                                <c:if test="${requestScope.FEEDBACK != null}">
                                    <a href="DeleteFeedback?roomNo=${param.roomNo}" class="btn btn-danger">Delete</a>
                                </c:if>
                                <input type="submit" class="btn btn-success" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="components/footer.jsp"></jsp:include>
        <script src="js/viewRoom.js"></script>
    </body >
</html >