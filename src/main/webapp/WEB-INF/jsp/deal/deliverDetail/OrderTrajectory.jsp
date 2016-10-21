<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<div class="followBottom">
    <table class="Table tbStyle remarks">
        <tr>
            <td ><span class="LabelNeed">备注</span></td>
            <td colspan="2" class="Relative">
                <textarea name="content" class="fl" cols="30" rows="5" placeholder="这是一条备注" required></textarea>
                <div class="FormLayout FormItemControl FileUploadWrapper">
                    <input class="ImageSourceUrl ImageInput" type="text"  name="image" value=""  >
                    <div class="PreShowList">
                        <input type="hidden" name="imagePreFix" id="ImagePreFix" value="${map.imageUrl}">
                    </div>
                    <div class="UploadBtnWrapper">
                        <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" multiple>
                        <a class="Btn" href="javascript:;">上传图片</a>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div class="ActionArea ClearFix">
        <c:if test="${orderInfo.orderStatus == 3 || orderInfo.orderStatus == 5 }">
            <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit " data-pending="保存中..." >提交</button>
        </c:if>
        <c:if test="${orderInfo.orderStatus != 3 && orderInfo.orderStatus != 5 }">
            <c:if test="${orderInfo.orderStatus ==4 && orderInfo.orderType == 1 }">
                <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit " data-pending="保存中..." >提交</button>
            </c:if>
            <c:if test="${orderInfo.orderStatus !=4 || orderInfo.orderType != 1 }">
                <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit Disabled" data-pending="保存中..." >提交</button>
            </c:if>
        </c:if>
    </div>
</div>
