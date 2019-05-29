package com.nono.dq.dao.local.metadata;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.nono.dq.model.dto.metadata.DqRuleAe;

@Repository
public interface DqRuleAeRepo extends CrudRepository<DqRuleAe, Integer> {
 
}