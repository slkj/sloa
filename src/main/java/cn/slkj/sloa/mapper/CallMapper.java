package cn.slkj.sloa.mapper;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;

import cn.slkj.sloa.entity.shfw.Call;

/**
 * 客服来电
 * 
 * @author xiaotianliang
 *
 */
public interface CallMapper {

	List<Call> getAll(Map<String, Object> map, PageBounds pageBounds);

	int insert(Call call);

}
